class UsersController < ApplicationController
  load_and_authorize_resource only: [:password, :set_password]
  skip_authorization_check except: [:password, :set_password]
  before_action :load_user, only: [:show, :password, :set_password]

  def index
    respond_with(@users = User.all.paginate(:page => params[:page], :per_page => 36))
  end
  
  def show    
  end

  def registration_via_provider
    User.registration_via_provider(params[:user][:email], session[:provider], session[:uid])
    redirect_to new_user_session_path, notice: 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
  end

  def authorization_confirmation
    auth = Authorization.confirm_by_token(params[:confirmation_token])
    if auth
      flash[:notice] = "Successfully authenticated from #{auth.provider.capitalize} account."
      sign_in_and_redirect auth.user, event: :authentication
    else
      redirect_to new_user_session_path, flash: {error: 'Confirmation is not satisfied.'}
    end
  end

  def password
    render layout: 'devise'
  end

  def set_password
    if @user.set_password(user_params)
      redirect_to root_path, notice: 'Password successfully created.'
    else
      render 'password', layout: 'devise'
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
