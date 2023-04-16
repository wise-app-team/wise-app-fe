class UsersController < ApplicationController
  def show
    # @user = BackendService.new.show_user(user_params)
  end

  def new

  end

  def create
    # response = BackendService.new.save_user(user_params)
 
    user_attributes = {
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      birthday: params[:birthday],
      phone_number: params[:phone_number],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code]
    }

    response = BackendService.new.save_user(user_attributes)

    if response.status == 201
      user_id = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
      redirect_to user_path(user_id[:data][:id].to_i)
    else
      flash[:error] = "Could not save user"
      # redirect_to new_user_path
      render :new
    end
        # handle the response as needed

    # @user = User.new(user_params)

    # if @user.save_to_db
    #   # User saved successfully on the backend
    # else
    #   # There was an error saving the user on the backend
    #   flash[:error] = "Could not save user"
    #   # redirect_to new_user_path
    #   render :new
    # end
  end


  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthday, :phone_number, address: [:street_address, :city, :state, :zip_code])
  end
end