Rails.application.routes.draw do
  root 'homepage#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

  get '/search', to: 'search#index'

  resources :listings, only: [:index, :show]

  resources :users, only: [:new, :create, :edit, :update] do
    resources :dashboard, only: [:index]

    namespace :host do
      resources :listings, only: [:new, :create]
      resources :dashboard, only: [:index]
    end
  end
end
