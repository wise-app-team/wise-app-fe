class UsersController < ApplicationController
  def new

  end

  def create
    response = BackendService.new.save_user(user_params)
    
    if response.status == 200
      # User saved successfully on the backend
      redirect_to dashboard_path
    else
      # There was an error saving the user on the backend
      flash[:error] = "Could not save user"
      redirect_to new_user_path
    end
  end
  
  def show
    @user = User.find(session[:user_id])
  end


  private
  
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthday, :phone_number, :street_address, :city, :state, :zip_code)
  end
end