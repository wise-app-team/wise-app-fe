class UsersController < ApplicationController
  def show
    # @user = BackendService.new.show_user(user_params)
  end

  def new

  end

  def login
  end

  def login_user
    response = BackendFacade.new.user_logging_in(user_params)
    if response.status == 200
      user_id = JSON.parse(response.body, symbolize_names: true)
      redirect_to user_path(user_id[:data][:id].to_i)
    else 
      flash[:error] = "Invalid Credentials"
      render :login, status: 400
    end
  end

  def create
		name = "#{params[:first_name]} #{params[:last_name]}"
    user_attributes = {
				name: name,
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
      redirect_to user_path(user_id[:data][:id].to_i)
    else
      flash[:error] = "User not created"
      render :new, status: 422
      # redirect_to new_user_path, status: 422
    end
  end
  
  # def show
  #   @user = User.find(session[:user_id])
  # end



  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthday, :phone_number, :street_address, :city, :state, :zip_code, :token, :drug, :user_drugs)
  end
end