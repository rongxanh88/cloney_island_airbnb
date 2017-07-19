Rails.application.routes.draw do
  root 'homepage#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  resources :confirmations, only: [:new, :create]
  # get '/confirmations', to: 'confirmations#new'
  # post '/confirmations', to: 'confirmations#create'

  get '/search', to: 'search#index'

  resources :listings, only: [:index, :show] do
    resources :trips, only: [:new, :create]
  end

  resources :users, only: [:new, :create, :edit, :update] do
    resources :dashboard, only: [:index]

    namespace :host do
      resources :listings, only: [:index, :show, :new, :create, :edit, :update]
    end
  end

  namespace :host do
    resources :dashboard, only: [:index]
  end

  resources :trips, only: [:index]

  namespace :api do
    namespace :v1 do
      get '/access_token', to: 'jwt#create'
      post '/integration/listings', to: 'integration/listings#create'
    end
  end
end