class CustomFieldsController < ApplicationController
  before_action :set_custom_field, only: %i[ show update destroy ]

  # GET /custom_fields
  def index
    @custom_fields = CustomField.all

    render json: @custom_fields
  end

  # GET /custom_fields/1
  def show
    render json: @custom_field
  end

  # POST /custom_fields
  def create
    @custom_field = CustomField.new(custom_field_params)

    if @custom_field.save
      render json: @custom_field, status: :created, location: @custom_field
    else
      render json: @custom_field.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /custom_fields/1
  def update
    if @custom_field.update(custom_field_params)
      render json: @custom_field
    else
      render json: @custom_field.errors, status: :unprocessable_entity
    end
  end

  # DELETE /custom_fields/1
  def destroy
    @custom_field.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_field
      @custom_field = CustomField.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def custom_field_params
      params.expect(custom_field: [ :name, :value, :login_id ])
    end
end
