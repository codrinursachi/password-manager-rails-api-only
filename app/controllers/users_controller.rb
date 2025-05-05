class UsersController < ApplicationController
  skip_before_action :authenticate_user
  def create
    @user = User.new(user_params)
    if @user.save
      @user.folders << [ Folder.new(name: "No folder"), Folder.new(name: "Email"), Folder.new(name: "Social media"), Folder.new(name: "Banking"), Folder.new(name: "Shopping"), Folder.new(name: "Work"), Folder.new(name: "Other") ]
      payload = {}
      payload[:exp] = 30.minutes.from_now.to_i
      payload[:iat] = Time.now.to_i
      payload[:user_id] = @user.id
      response.headers["Authorization"] = JWT.encode(payload, Rails.application.secret_key_base.to_s)
      render json: { message: "User created successfully" }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      payload = {}
      payload[:exp] = 30.minutes.from_now.to_i
      payload[:iat] = Time.now.to_i
      payload[:user_id] = @user.id
      response.headers["Authorization"] = JWT.encode(payload, Rails.application.secret_key_base.to_s)
      render json: { message: "Login successful", salt: @user.salt, private_key: @user.rsa.private_key, private_key_iv: @user.rsa.private_key_iv }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :salt, rsa_attributes: [ :public_key, :private_key, :private_key_iv ])
  end
end
