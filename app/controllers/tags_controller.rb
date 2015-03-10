class TagsController < ApplicationController
  skip_authorization_check
  respond_to :html

  def index
    respond_with(@tags = Tag.all.paginate(:page => params[:page], :per_page => 36))
  end
end