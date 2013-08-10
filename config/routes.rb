Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'sessions#front'
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/home", to: "categories#index"

  resources :videos, only: [:show] do
    collection do
       post "search", to: "videos#search"
    end
  end

  resources :users, only: [:create, :show]
  resources :categories, only: [:show]
end
