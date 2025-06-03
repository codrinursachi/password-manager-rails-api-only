class WebauthnController < ApplicationController
  skip_before_action :authenticate_user

  def registration_options
    user = User.create!(
      email: params[:email],
      name: params[:name],
      salt: params[:salt]
    )
    user.folders << [
      Folder.new(name: "No folder"),
      Folder.new(name: "Email"),
      Folder.new(name: "Social media"),
      Folder.new(name: "Banking"),
      Folder.new(name: "Shopping"),
      Folder.new(name: "Work"),
      Folder.new(name: "Other")
    ]
    @creation_options = WebAuthn::Credential.options_for_create(
      user: {
        id: user.id.to_s,
        name: user.name,
        display_name: user.name
      },
      authenticator_selection: { user_verification: "required" },
    )

    @challenge_token = JWT.encode(
      {
        user_id: user.id,
        challenge: @creation_options.challenge,
        action: "registration",
        exp: 5.minutes.from_now.to_i
      },
      Rails.application.secret_key_base,
      "HS256"
    )
  end

  def register
    begin
      challenge_token = params[:challenge_token]
      payload = JWT.decode(
        challenge_token,
        Rails.application.secret_key_base,
        true,
        { algorithm: "HS256" }
      ).first
      @user = User.find(payload["user_id"])
      credential_with_attestation = WebAuthn::Credential.from_create(
          params[:publicKeyCredential]
        )

      credential_with_attestation.verify(payload["challenge"])

      @user.update!(
        credential_id: credential_with_attestation.id,
        public_key: credential_with_attestation.public_key,
        sign_count: credential_with_attestation.sign_count,
        rsa_attributes: {
          public_key: params[:rsa_attributes][:public_key],
          private_key: params[:rsa_attributes][:private_key],
          private_key_iv: params[:rsa_attributes][:private_key_iv]
        },
      )

      generate_token
    rescue WebAuthn::Error, JWT::DecodeError => e
      render locals: { error: e.message }, status: :unprocessable_entity
    end
  end

  def authentication_options
    user = User.find_by(email: params[:email])
    unless user && user.credential_id
      return render locals: { error: "User not registered with passkeys" }, status: :not_found
    end

    @request_options = WebAuthn::Credential.options_for_get(allow: [ user.credential_id ])
    @challenge_token = JWT.encode(
      {
        user_id: user.id,
        challenge: @request_options.challenge,
        action: "authentication",
        exp: 5.minutes.from_now.to_i
      },
      Rails.application.secret_key_base,
      "HS256"
    )
  end

  def authenticate
    begin
      challenge_token = params[:challenge_token]
      payload = JWT.decode(
        challenge_token,
        Rails.application.secret_key_base,
        true,
        { algorithm: "HS256" }
      ).first
      @user = User.find(payload["user_id"])
      unless @user
        return render locals: { error: "User not found" }, status: :unauthorized
      end

      credential_with_assertion = WebAuthn::Credential.from_get(
          params[:publicKeyCredential]
        )

      credential_with_assertion.verify(
        payload["challenge"],
        public_key: @user.public_key,
        sign_count: @user.sign_count
      )

      @user.update!(sign_count: credential_with_assertion.sign_count)

      generate_token
    rescue WebAuthn::Error, JWT::DecodeError => e
      render locals: { error: e.message }, status: :unauthorized
    end
  end
end
