class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :answers
  has_many :questions
  has_many :authorizations, dependent: :destroy

  acts_as_voter

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    if email
      user = User.where(email: email).first
      if user
        user.create_authorization(auth.provider, auth.uid)
      else
        password = Devise.friendly_token[0, 20]
        user = User.create!(email: email, password: password, password_confirmation: password, confirmed_at: Time.now)
        user.create_authorization(auth.provider, auth.uid)
      end
    else
      user = User.new
    end

    user
  end

  def create_authorization(provider, uid)
    self.authorizations.create(provider: provider, uid: uid)
  end
end
