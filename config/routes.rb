Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

 get "/home", to: "videos#index"
 # get "/home", to: "videos#home"
 # get "/videos/:id", to: "videos#video"
  resources :videos, only: [:show]
end
