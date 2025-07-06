WebAuthn.configure do |config|
  config.allowed_origins = ["http://localhost:5173", "http://localhost:3001"] # Replace with your domain
  config.rp_name = "Password Manager"
  config.rp_id = "localhost"
end
