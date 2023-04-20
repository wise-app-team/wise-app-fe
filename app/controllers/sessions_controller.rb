class SessionsController < ApplicationController
  def create
    # auth_hash = request.env['omniauth.auth']
    # user = User.from_omniauth(auth_hash)
    user = BackendService.new.user_create_by_oauth(auth_hash) #user_create_or_find(auth_hash)
    
    redirect_to '/dashboard'
  end
  
  def google_oauth2_callback
    # require 'pry'; binding.pry
    auth_hash
    user = User.find_or_create_by(google_id: auth_hash[:uid]) do |u|
      # u.google_id = auth_hash[:uid]
      # binding.pry
      u.email = auth_hash[:info][:email]
      u.name = auth_hash[:info][:name]
      u.token = auth_hash[:credentials][:token]
      u.provider = auth_hash[:provider]
    end
    session[:user_id] = user.id
    redirect_to dashboard_path
  end
  
  private
  
  def auth_hash
    # require 'pry'; binding.pry
    request.env['omniauth.auth']
    
    # binding.pry
  end
end