class UsersController < ApplicationController
  def show
    @user = BackendService.new.show_user(user_params)
  end

  def new

  end

  def create
    # response = BackendService.new.save_user(user_params)

    @user = User.new(user_params)

    if @user.save
      # User saved successfully on the backend
      redirect_to user_path(@user)
    else
      # There was an error saving the user on the backend
      flash[:error] = "Could not save user"
      # redirect_to new_user_path
      render :new
    end
  end


  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthday, :phone_number, address: [:street_address, :city, :state, :zip_code])
  end
end