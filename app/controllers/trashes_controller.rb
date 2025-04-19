class TrashesController < ApplicationController
  load_and_authorize_resource :login, parent: false
  def index
    @logins = @logins.by_is_in_trash(true)
    render json: @logins.includes(:urls).map { |login|
      {
        login_id: login.id,
        name: login.name,
        login_name: login.login_name,
        login_password: login.login_password,
        file: login.file.attached? ? rails_blob_path(login.file, disposition: "attachment") : nil,
        urls: login.urls.map(&:uri),
        trash_date: login.trash_date
      }
    }
  end

  def destroy
    Login.accessible_by(current_ability).find(params[:id]).destroy!
  end

  def restore
    @login = Login.accessible_by(current_ability).find(params[:id])
    @login.update(trash_date: nil)
  end
end
