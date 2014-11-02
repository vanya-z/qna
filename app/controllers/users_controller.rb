class UsersController < ApplicationController
  before_action :load_user, only: :show
  
  def show    
  end

  def registration_via_provider #TODO for very very
    password = Devise.friendly_token[0, 20]
    @user = User.create!(user_params.merge(password: password, password_confirmation: password))
    @user.create_authorization(session[:provider].to_s, session[:uid].to_s)
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: session[:provider].capitalize) if is_navigational_format?
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
