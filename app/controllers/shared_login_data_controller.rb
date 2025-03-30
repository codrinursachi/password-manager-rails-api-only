class SharedLoginDataController < ApplicationController
  before_action :set_shared_login_datum, only: %i[ show update destroy ]

  # GET /shared_login_data
  def index
    @shared_login_data = SharedLoginDatum.all

    render json: @shared_login_data
  end

  # GET /shared_login_data/1
  def show
    render json: @shared_login_datum
  end

  # POST /shared_login_data
  def create
    @shared_login_datum = SharedLoginDatum.new(shared_login_datum_params)

    if @shared_login_datum.save
      render json: @shared_login_datum, status: :created, location: @shared_login_datum
    else
      render json: @shared_login_datum.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /shared_login_data/1
  def update
    if @shared_login_datum.update(shared_login_datum_params)
      render json: @shared_login_datum
    else
      render json: @shared_login_datum.errors, status: :unprocessable_entity
    end
  end

  # DELETE /shared_login_data/1
  def destroy
    @shared_login_datum.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shared_login_datum
      @shared_login_datum = SharedLoginDatum.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def shared_login_datum_params
      params.expect(shared_login_datum: [ :login_id, :user_id ])
    end
end
