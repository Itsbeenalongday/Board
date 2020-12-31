class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :pretty_date, :pretty_time

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
    devise_parameter_sanitizer.permit :account_update, keys: [:name]
  end

  def pretty_time(time = nil)
    time.methods.include?(:strftime) ? time.strftime("%Y-%m-%d %H:%M") : ""
  end

  def pretty_date(time = nil)
    time.methods.include?(:strftime) ? time.strftime("%Y-%m-%d") : ""
  end

end
