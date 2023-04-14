Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: 'landing#index'
  get '/dashboard', to: 'users#show'
  resources :users, only: [:show, :new, :create] do 
    resources :medical, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      get '/drugs/find_all', to: 'drugs/search#find_all'
      resources :users, only: [:create]

    end
  end
end
