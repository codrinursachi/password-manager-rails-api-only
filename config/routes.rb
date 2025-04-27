Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :trashes, only: [ :index, :destroy ]
      patch "trashes/:id", to: "trashes#restore"
      resources :shared_login_data
      resources :logins
      resources :folders
      post "/register", to: "users#create"
      post "/login", to: "users#login"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
