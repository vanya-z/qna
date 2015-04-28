class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter, :github, :vkontakte]
  has_many :answers
  has_many :questions
  has_many :authorizations, dependent: :destroy

  validate :password, presence: true, length: { in: 6..128 }, on: :set_password

  acts_as_voter

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization && authorization.confirmed_at?

    email = auth.info[:email]
    if email
      user = User.where(email: email).first
      if user
        user.create_authorization(auth.provider, auth.uid, Time.now)
      else
        user = User.create_confirmed_user(email)
        user.create_authorization(auth.provider, auth.uid, Time.now)
      end
    else
      user = User.new
    end

    user
  end

  def self.registration_via_provider(email, provider, uid)
    token = self.authorization_confirmation_token
    user = self.find_by(email: email) || self.create_confirmed_user(email)
    user.find_or_create_unconfirmed_authorization(provider, uid, token)
    self.send_authorization_confirmation(email, token, provider)
  end

  def self.authorization_confirmation_token
    token = SecureRandom.urlsafe_base64
    while Authorization.find_by(confirmation_token: token).present? do
      token = SecureRandom.urlsafe_base64
    end
    token
  end

  def self.create_confirmed_user(email)
    password = Devise.friendly_token[0, 20]
    self.create!(email: email, password: password, password_confirmation: password, confirmed_at: Time.now, password_is_set: false)
  end

  def create_authorization(provider, uid, confirmed_at)
    self.authorizations.create(provider: provider, uid: uid, confirmed_at: confirmed_at)
  end

  def find_or_create_unconfirmed_authorization(provider, uid, confirmation_token)
    auth = self.authorizations.find_or_create_by(provider: provider, uid: uid)
    auth.update_attributes(confirmation_token: confirmation_token, confirmation_token_sent_at: Time.now)
  end

  def self.send_authorization_confirmation(email, token, provider)
    UserMailer.authorization_confirmation(email, token, provider).deliver    
  end

  def set_password(user_params)
    self.update(user_params.merge(password_is_set: true))
  end
end
