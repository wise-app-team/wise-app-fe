class SessionsController < ApplicationController
  def create
    # auth_hash = request.env['omniauth.auth']
    # user = User.from_omniauth(auth_hash)
    user = BackendService.new.user_create_by_oauth(auth_hash) #user_create_or_find(auth_hash)
    
    # session[:user_id]    = user_params[:google_id]
    # session[:user_email] = user_params[:email]
    # session[:user_token] = user_params[:google_token]
    binding.pry
    # session[:user_id] = user.id
    
    redirect_to '/dashboard'
  end
  
  private
  
  def auth_hash
    x = request.env['omniauth.auth']
    
    # binding.pry
  end
end


# Trails n Brews method
# BackendService.register_user(google_id, email, token)
# session[:user_id]    = user_params[:google_id]
# session[:user_email] = user_params[:email]
# session[:user_token] = user_params[:google_token]
# 
# redirect_to user_path