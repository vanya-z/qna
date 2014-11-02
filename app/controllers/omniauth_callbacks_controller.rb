class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :auth
  before_action :find_user

  def facebook
  end

  def twitter
  end

  private

  def find_user
    @user = User.find_for_oauth(auth)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: auth.provider.capitalize) if is_navigational_format?
    else
      session[:provider], session[:uid] = auth.provider, auth.uid.to_s
      render 'devise/set_email'
    end
  end

  def auth
    request.env['omniauth.auth']
  end
end