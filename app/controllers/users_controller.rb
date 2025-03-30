class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  # POST /users
  def create
    @user = User.new(user_params)
    @user.folders << [ Folder.new(name: "No folder"), Folder.new(name: "Email"), Folder.new(name: "Social media"), Folder.new(name: "Banking"), Folder.new(name: "Shopping"), Folder.new(name: "Work"), Folder.new(name: "Other") ]

    if @user.save
      start_new_session_for @user
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation, :first_name, :last_name)
    end
end
