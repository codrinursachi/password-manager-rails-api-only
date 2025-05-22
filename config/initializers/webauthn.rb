WebAuthn.configure do |config|
  config.allowed_origins = "http://localhost:5173" # Replace with your domain
  config.rp_name = "Password Manager"
  config.rp_id = "localhost"
end
