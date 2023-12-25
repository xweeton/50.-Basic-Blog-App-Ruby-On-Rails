Rails.application.routes.draw do
  # devise
  devise_for :users

  # Defines the root path route ("/")
  root 'articles#index'

  # resources is shortcut to not repeat crud routes, but need to follow 7 default actions in controller(means in views also need the same 7 actions'name)
  resources :articles do
    resources :comments
  end

  resources :users, only: [:show, :edit, :update]

  # error page
  get "/404", to: "errors#not_found"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # route not found, then give error page, not including active_storage to avoid images crash
  match '*path', to: 'errors#not_found', via: :all, constraints: lambda { |req|
    !req.path.starts_with?('/rails/active_storage')
  }
  match "/404", :to => "errors#not_found", :via => :all
end
