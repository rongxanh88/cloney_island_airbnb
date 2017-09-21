Rails.application.routes.draw do
  root 'listings#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  mount ActionCable.server, at: '/cable'

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

  resources :trips, only: [:index, :update] do
  end
  resources :experiences, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :messages , only: [:create]
  resources :conversations, only: [:index, :show, :create]
end
