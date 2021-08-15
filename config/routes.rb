Rails.application.routes.draw do

  get '/trips/most_expensive', to: 'trips#most_expensive'
  root to: 'sessions#welcome'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :travels
  resources :trips, only: [:index, :new, :create]
  resources :locations do
    resources :trips, shallow: true
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
