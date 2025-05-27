class SharedLoginDataController < ApplicationController
  authorize_resource except: [ :create ]
  # GET /shared_login_data
  def index
    @shared_login_data = SharedLoginDatum.accessible_by(current_ability)
    @shared_login_data = @shared_login_data.by_current_user(params[:by_me] == "true", current_user.id)
  end

  def new
    user = User.find_by(email: params[:email])
    if user
      render "shared_login_data/public_key", locals: { public_key: user.rsa.public_key }
    else
      render "errors/error", locals: { error: "User not found" }, status: :not_found
    end
  end

  # POST /shared_login_data
  def create
    email, login_id, password = params.require(:shared_login_datum).permit(:email, :login_id, :password).values_at(:email, :login_id, :password)
    user = User.find_by(email: email)
    if user
      @shared_login_datum = SharedLoginDatum.new(login_id:, user_id: user.id, password: password)
    else
      render "errors/error", locals: { error: "User not found" }, status: :unprocessable_entity
      return
    end
    if @shared_login_datum.save
      render "shared_login_data/shared_login_datum", locals: { shared_login_datum: @shared_login_datum.slice(:id, :login_id) }, status: :created, location: @shared_login_datum
    else
      render "errors/error", locals: { error: @shared_login_datum.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /shared_login_data/1
  def destroy
    @shared_login_datum = SharedLoginDatum.accessible_by(current_ability).find(params[:id])
    @shared_login_datum.destroy!
  end
end
