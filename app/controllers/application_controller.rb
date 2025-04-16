class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug current_user
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    render json: { error: exception.message }, status: :forbidden
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
