class UsersController < ApplicationController
  def show
    # @user = BackendService.new.show_user(user_params)
  end

  def new

  end

  def create
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
    # binding.pry
    if response.status == 201
      user_id = JSON.parse(response.body, symbolize_names: true)
      redirect_to user_path(user_id[:data][:id].to_i)
    else
      flash[:error] = "User not created"
      render :new, status: 422
      # redirect_to new_user_path, status: 422
    end
  end


  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthday, :phone_number, address: [:street_address, :city, :state, :zip_code])
  end
end