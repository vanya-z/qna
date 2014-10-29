class UsersController < ApplicationController
  before_action :load_user, only: :show
  
  def show    
  end

  private

  def load_user
    @user = User.find(params[:id])
  end
end
