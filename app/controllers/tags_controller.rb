class TagsController < ApplicationController
  skip_authorization_check
  respond_to :html

  def index
    respond_with(@tags = Tag.tabing(tab_params).paginate(:page => params[:page], :per_page => 36))
  end

  private

  def tab_params
    tab = ['popular', 'name', 'new'].include?(params[:tab]) ? params[:tab] : cookies[:tags_tab] || 'popular'
    cookies[:tags_tab] = tab
    tab
  end
end