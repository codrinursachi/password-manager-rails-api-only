class ApplicationController < ActionController::API
  include Authentication

  private
  def current_user
    Current.user
  end
end
