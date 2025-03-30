class TrashesController < ApplicationController
  before_action :set_trash, only: %i[ show update destroy ]

  # GET /trashes
  def index
    @trashes = Trash.all

    render json: @trashes
  end

  # GET /trashes/1
  def show
    render json: @trash
  end

  # POST /trashes
  def create
    @trash = Trash.new(trash_params)

    if @trash.save
      render json: @trash, status: :created, location: @trash
    else
      render json: @trash.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trashes/1
  def update
    if @trash.update(trash_params)
      render json: @trash
    else
      render json: @trash.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trashes/1
  def destroy
    @trash.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trash
      @trash = Trash.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def trash_params
      params.fetch(:trash, {})
    end
end
