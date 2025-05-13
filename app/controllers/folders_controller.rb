class FoldersController < ApplicationController
  load_and_authorize_resource

  # GET /folders
  def index
    render json: @folders
  end

  # POST /folders
  def create
    if @folder.save
      render json: @folder, status: :created, location: @folder
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /folders/1
  def update
    if @folder.update(folder_params)
      render json: @folder
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def folder_params
      params.expect(folder: [ :name, :user_id ])
    end
end
