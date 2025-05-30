Rails.application.routes.draw do
  resources :sshkeys
  scope :api do
    scope :v1 do
      resources :sshkeys
      resources :notes, only: %i[ index show create update destroy ]
      resources :trashes, only: %i[ index destroy ]
      patch "trashes/:id", to: "trashes#restore"
      resources :shared_login_data, only: %i[ index new create destroy ]
      resources :logins
      resources :folders
      post "/register", to: "users#create"
      post "/login", to: "users#login"
      post  "webauthn/registration_options", to: "webauthn#registration_options"
      post  "webauthn/register", to: "webauthn#register"
      post  "webauthn/authentication_options", to: "webauthn#authentication_options"
      post  "webauthn/authenticate", to: "webauthn#authenticate"
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
