class NotesController < ApplicationController
  load_and_authorize_resource

  # GET /notes
  def index
    render json: @notes
  end

  # POST /notes
  def create
    if @note.save
      render json: @note, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def note_params
      params.expect(note: [ :text, :iv ])
    end
end
