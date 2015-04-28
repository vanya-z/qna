class UserMailer < ActionMailer::Base
  default from: '"QNA Sample" <ivan.z.1984@gmail.com>'

  def authorization_confirmation(email, token, provider)
    @email = email
    @token = token
    @provider = provider
    mail(to: email, subject: "Confirmation instructions")
  end
end
