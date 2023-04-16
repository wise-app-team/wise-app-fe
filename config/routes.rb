Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: 'landing#index'

  post "/users/new", to: "users#create"
  
  resources :users, only: [:show, :new] do 
    resources :meds, only: [:index] do
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
