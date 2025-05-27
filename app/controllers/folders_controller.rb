class FoldersController < ApplicationController
  load_and_authorize_resource

  # GET /folders
  def index
  end

  # POST /folders
  def create
    if @folder.save
      render "folders/folder", status: :created
    else
      render "errors/error", locals: { error: @folder.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /folders/1
  def update
    if @folder.update(folder_params)
      render "folders/folder", status: :ok
    else
      render "errors/error", locals: { error: @folder.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def folder_params
      params.expect(folder: %i[ name user_id ])
    end
end
