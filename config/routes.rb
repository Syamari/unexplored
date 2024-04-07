Rails.application.routes.draw do
  root 'tops#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'terms', to: 'tops#terms'
  get 'policy', to: 'tops#policy'

  resources :users, only: %i[new create edit update]


  resources :lists do
    resources :artists, controller: 'list_artists', only: [:create, :destroy] do
      collection do
        get 'search'
      end
    end
    resources :songs do
      post 'rate', on: :member
    end
    resource :bookmark, only: [:create, :destroy]
  end

  resources :rates, only: [:index, :show, :update]

end