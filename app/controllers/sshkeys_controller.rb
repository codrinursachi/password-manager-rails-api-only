class SshkeysController < ApplicationController
  load_and_authorize_resource

  # GET /sshkeys
  def index
    render json: @sshkeys
  end

  # GET /sshkeys/1
  def show
    render json: @sshkey
  end

  # POST /sshkeys
  def create
    if @sshkey.save
      render json: @sshkey, status: :created, location: @sshkey
    else
      render json: @sshkey.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sshkeys/1
  def update
    if @sshkey.update(sshkey_params)
      render json: @sshkey
    else
      render json: @sshkey.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sshkeys/1
  def destroy
    @sshkey.destroy!
  end

  private
    # Only allow a list of trusted parameters through.
    def sshkey_params
      params.expect(sshkey: [ :name, :private_key, :iv, :public_key, :notes ])
    end
end
