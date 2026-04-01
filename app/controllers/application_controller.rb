class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :phone, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address, :phone, :province_id])
  end
end