class SearchController < ApplicationController
  skip_authorization_check

  def index
    @results = ThinkingSphinx.search params[:q]
  end
end