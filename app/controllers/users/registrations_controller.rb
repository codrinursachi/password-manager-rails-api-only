# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix

  respond_to :json
  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: "Signed up successfully." },
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
      current_user.folders << [ Folder.new(name: "No folder"), Folder.new(name: "Email"), Folder.new(name: "Social media"), Folder.new(name: "Banking"), Folder.new(name: "Shopping"), Folder.new(name: "Work"), Folder.new(name: "Other") ]
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end
