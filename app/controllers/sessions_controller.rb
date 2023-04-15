class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    google_id = auth_hash["uid"]
    email = auth_hash["info"]["email"]
    token = auth_hash["credentials"]["token"]
    binding.pry
    
    
    
    BackendService.register_user(google_id, email, token)
    # session[:user_id]    = user_params[:google_id]
    # session[:user_email] = user_params[:email]
    # session[:user_token] = user_params[:google_token]
    # 
    # redirect_to user_path
  end
  
end