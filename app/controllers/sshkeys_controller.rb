class SshkeysController < ApplicationController
  load_and_authorize_resource

  # GET /sshkeys
  def index
  end

  # GET /sshkeys/1
  def show
  end

  # POST /sshkeys
  def create
    if @sshkey.save
      render "sshkeys/show", status: :created, location: @sshkey
    else
      render locals: { error: @sshkey.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sshkeys/1
  def update
    if @sshkey.update(sshkey_params)
      render "sshkeys/show", status: :ok, location: @sshkey
    else
      render locals: { error: @sshkey.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /sshkeys/1
  def destroy
    @sshkey.destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def sshkey_params
      params.expect(sshkey: %i[ name private_key iv public_key notes ])
    end
end
