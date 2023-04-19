Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	get '/dashboard', to: 'users#show'
  get "/auth/:provider/callback", to: 'sessions#create' 

  get '/', to: 'landing#index'
  get '/login', to: 'users#login'
  post '/login', to: 'users#login_user'

  get '/dashboard', to: 'users#show'
  
  get "/auth/:provider/callback", to: 'sessions#create' 
      #(:provider functions as a placeholder in case we implement another one)
  post "/users/new", to: "users#create"

      resources :users, only: [:show, :new] do 
        post '/meds/new', to: 'drugs#create'
        get '/meds/new', to: 'meds#new'
        resources :meds, only: [:index, :edit, :destroy] do
          resources :search, only: [:index]
        end
      end

  namespace :api do
    namespace :v1 do
      get '/drugs/find_all', to: 'drugs/search#find_all'
      resources :users, only: [:show, :create]
    end
  end
end
