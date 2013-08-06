Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

 #get "/home", to: "videos#index"
  #get "/home", to: "videos#index"
  #get "/videos/:id", to: "videos#show", as: 'video_path'
  resources :videos, only: [:show]
  resources :categories, only: [:show, :index]
end
