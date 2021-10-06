Rails.application.routes.draw do
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/create_fast",  to: "users#create_fast"
  get "/main", to: "users#main"
  get "/check_user", to: "users#check_user"
  get "/create_new_post", to: "users#create_post"
  #get "/create_new_from_user", to: "users#create_new_from_user"

end
