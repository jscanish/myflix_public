Myflix::Application.routes.draw do
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/home", to: "categories#index"
  get "/my_queue", to: "queue_items#index"

  resources :users, only: [:create, :show]
  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
       post "search", to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'
end
