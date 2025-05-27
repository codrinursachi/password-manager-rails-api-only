class TrashesController < ApplicationController
  load_and_authorize_resource :login, parent: false
  def index
    @logins = @logins.by_is_in_trash(true)
  end

  def destroy
    Login.accessible_by(current_ability).find(params[:id]).destroy!
  end

  def restore
    @login = Login.accessible_by(current_ability).find(params[:id])
    if @login.update(trash_date: nil)
      render "messages/message", locals: { message: "Login restored successfully" }, status: :ok
    end
  end
end
