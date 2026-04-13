class PagesController < ApplicationController
  def show
    # Finds the page in the database where the permalink matches the URL request
    @page = Page.find_by!(permalink: params[:permalink])
  end
end