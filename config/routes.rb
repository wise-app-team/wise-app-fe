Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	get '/dashboard', to: 'users#show'
  # post "/auth/:provider/callback", to: 'sessions#create'  # Doesn't look like we need this?
	# post '/auth/google_oauth2/callback', to: 'sessions#create_with_google'

  # post "/auth/:provider/callback", to: 'users#create' 

  get '/', to: 'landing#index'
  get '/login', to: 'users#login'
  post '/login', to: 'users#login_user'

  get '/dashboard', to: 'users#show'
  
  get "/auth/:provider/callback", to: 'sessions#create' 
      #(:provider functions as a placeholder in case we implement another one)
  post "/users/new", to: "users#create"

      resources :users, only: [:show, :new] do 
        post '/drugs', to: 'drugs#create'
        get '/meds/new', to: 'meds#new'
        post '/meds/new', to: 'meds#create'
        resources :meds, only: [:index, :edit, :destroy, :create] do
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
