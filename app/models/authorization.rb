class Authorization < ActiveRecord::Base
  belongs_to :user

  def self.confirm_by_token(token)
    authorization = Authorization.find_by(confirmation_token: token)
    if authorization && authorization.confirmation_token_sent_at > Time.now - 1.day
      authorization.update_attribute(:confirmed_at, Time.now)
      authorization.user.update_attribute(:confirmed_at, Time.now) unless authorization.user.confirmed_at\
    else
      authorization = nil
    end
    authorization
  end
end
