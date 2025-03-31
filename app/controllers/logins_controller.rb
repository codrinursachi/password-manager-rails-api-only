class LoginsController < ApplicationController
  load_and_authorize_resource

  # GET /logins
  def index
    filter_scopes = {
      not_in_trash: -> { @logins = @logins.by_is_in_trash(false) },
      favorite: -> { @logins = @logins.by_favorite },
      search: -> { params[:q].split.each { |p| @logins = @logins.search(p) } },
      folder: -> { @logins = @logins.by_folder(params[:folder_id]) }
    }

    filter_scopes[:not_in_trash].call
    filter_scopes[:favorite].call if params[:favorite].present?
    filter_scopes[:search].call if params[:q].present?
    @logins.includes(:folder)
    filter_scopes[:folder].call if params[:folder_id].present?

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
