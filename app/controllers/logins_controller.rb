class LoginsController < ApplicationController
  load_and_authorize_resource

  # GET /logins
  def index
    render json: @logins
  end

  # GET /logins/1
  def show
    render json: @login
  end

  # POST /logins
  def create
    if @login.save
      render json: @login, status: :created, location: @login
    else
      render json: @login.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logins/1
  def update
    if @login.update(login_params)
      render json: @login
    else
      render json: @login.errors, status: :unprocessable_entity
    end
  end

  # DELETE /logins/1
  def destroy
    @login.update(trash_date: Time.now)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def login_params
      params.expect(login: [ :name, :login_name, :login_password, :notes, :is_favorite, :folder_id, :file, urls_attributes, custom_fields_attributes ])
    end

    def urls_attributes
      { urls_attributes: [ [ :id, :uri ] ] }
    end

    def custom_fields_attributes
      { custom_fields_attributes: [ [ :id, :name, :value ] ] }
    end
end
