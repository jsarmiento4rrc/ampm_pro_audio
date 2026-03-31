class ApplicationController < ActionController::Base
  before_action :initialize_session

  private

  def initialize_session
    session[:cart] ||= {}
  end
end