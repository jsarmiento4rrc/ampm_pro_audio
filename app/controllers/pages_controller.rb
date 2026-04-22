class PagesController < ApplicationController
  def show
    # Fetch the page from the database using the permalink (e.g., 'about')
    @page = Page.find_by!(permalink: params[:permalink])
  rescue ActiveRecord::RecordNotFound
    # If a user types a URL that doesn't exist, send them home safely
    redirect_to root_path, alert: "Page not found."
  end
end