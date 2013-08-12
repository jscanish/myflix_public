Myflix::Application.routes.draw do
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/home", to: "categories#index"

  resources :users, only: [:create, :show]
  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
       post "search", to: "videos#search"
    end
  end

  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'
end
