class ApplicationController < ActionController::API
  before_action :authenticate_user

  protected
    rescue_from CanCan::AccessDenied do |exception|
      render "errors/error", locals: { error: exception.message }, status: :forbidden
    end

  private
    def current_user
      @current_user
    end

    def authenticate_user
      sleep 1.5
      header = request.headers["Authorization"]
      token = header.split(" ")[1]
      begin
        decoded = JWT.decode(token, Rails.application.secret_key_base.to_s)[0]
        @current_user = User.new(id: decoded["user_id"])
      rescue JWT::DecodeError
        render "errors/error", locals: { error: "Invalid token" }, status: :unauthorized
      end
    end

    def generate_token
      payload = {}
      payload[:exp] = 30.minutes.from_now.to_i
      payload[:iat] = Time.now.to_i
      payload[:user_id] = @user.id
      response.headers["Authorization"] = JWT.encode(
          payload,
          Rails.application.secret_key_base.to_s
        )
      response.set_header("Status", "ok")
    end
end
