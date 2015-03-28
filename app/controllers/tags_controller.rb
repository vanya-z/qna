class TagsController < ApplicationController
  skip_authorization_check
  respond_to :html

  def index
    respond_with(@tags = Tag.sorting(sort_params).paginate(:page => params[:page], :per_page => 36))
  end

  private

  def sort_params
    sort = ['popular', 'name', 'new'].include?(params[:tab]) ? params[:tab] : cookies[:tags_sort] || 'popular'
    cookies[:tags_sort] = sort
    sort
  end
end