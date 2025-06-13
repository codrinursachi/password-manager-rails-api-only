class UsersController < ApplicationController
  skip_before_action :authenticate_user
  def create
    @user = User.new(user_params)
    if @user.save
      @user.folders << [
        Folder.new(name: "No folder"),
        Folder.new(name: "Email"),
        Folder.new(name: "Social media"),
        Folder.new(name: "Banking"),
        Folder.new(name: "Shopping"),
        Folder.new(name: "Work"),
        Folder.new(name: "Other")
      ]
      generate_token
      render "messages/message", locals: { message: "User created successfully" }, status: :created
    else
      render "errors/error", locals: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      generate_token
    else
      render "errors/error", locals: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :salt,
      rsa_attributes: %i[ public_key private_key private_key_iv ])
  end
end
