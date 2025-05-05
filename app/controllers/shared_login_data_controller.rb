class SharedLoginDataController < ApplicationController
  authorize_resource except: [ :create, :destroy ]
  # GET /shared_login_data
  def index
    @shared_login_data = SharedLoginDatum.accessible_by(current_ability)
    @shared_login_data = @shared_login_data.by_current_user(params[:by_me] == "true", current_user.id)
    render json: @shared_login_data.map { |shared_login_datum|
      {
        id: shared_login_datum.id,
        login_id: shared_login_datum.login_id,
        shared_by: shared_login_datum.user.email,
        shared_with: User.find(shared_login_datum.user_id).email,
        name: shared_login_datum.login.login_name,
        login_name: shared_login_datum.login.login_name,
        login_password: shared_login_datum.password,
        file: shared_login_datum.login.file.attached? ? rails_blob_path(shared_login_datum.login.file, disposition: "attachment") : nil,
        urls: shared_login_datum.login.urls.map { |url| url.uri }
      }
    }
  end

  def new
    user = User.find_by(email: params[:email])
    if user
      render json: { public_key: user.rsa.public_key }
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  # POST /shared_login_data
  def create
    email, login_id, password = params.require(:shared_login_datum).permit(:email, :login_id, :password).values_at(:email, :login_id, :password)
    user = User.find_by(email: email)
    if user
      @shared_login_datum = SharedLoginDatum.new(login_id: login_id, user_id: user.id, password: password)
    else
      render json: { error: "User not found" }, status: :unprocessable_entity
      return
    end
    if @shared_login_datum.save
      render json: @shared_login_datum.slice(:id, :login_id), status: :created, location: @shared_login_datum
    else
      render json: @shared_login_datum.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shared_login_data/1
  def destroy
    @shared_login_datum = SharedLoginDatum.find(params[:id])
    @shared_login_datum.destroy!
  end
end
