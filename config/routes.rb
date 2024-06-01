Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :password_resets, only: [:create, :edit, :update]
  get 'password_resets/new', to: 'password_resets#new', as: 'new_password_reset'

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
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
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

  resources :artists do
    member do
      get 'top_tracks'
    end
    post 'rate', on: :member
  end

  resources :rates, only: [:index, :show, :update]

end