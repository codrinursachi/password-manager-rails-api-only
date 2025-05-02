class ApplicationController < ActionController::API
  before_action :authenticate_user

  protected
    rescue_from CanCan::AccessDenied do |exception|
      Rails.logger.debug current_user
      Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
      render json: { error: exception.message }, status: :forbidden
    end

  private
    def current_user
      @current_user
    end

    def authenticate_user
      header = request.headers["Authorization"]
      token = header.split(" ")[1]
      decoded = JWT.decode(token, Rails.application.secret_key_base.to_s)[0]
      @current_user = User.new(id: decoded["user_id"])
    end
end
