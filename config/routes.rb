Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	get '/dashboard', to: 'users#show'
  get "/auth/:provider/callback", to: 'sessions#create' 
  post "/auth/:provider/callback", to: 'users#create' 

  get '/', to: 'landing#index'

  get '/dashboard', to: 'users#show'
  get "/auth/:provider/callback", to: 'sessions#create' 
      #(:provider functions as a placeholder in case we implement another one)
  post "/users/new", to: "users#create"
      
  resources :users, only: [:show, :new] do 
    resources :meds, only: [:index, :edit] 
  end

  namespace :api do
    namespace :v1 do
      get '/drugs/find_all', to: 'drugs/search#find_all'
      resources :users, only: [:show, :create]
    end
  end
end
