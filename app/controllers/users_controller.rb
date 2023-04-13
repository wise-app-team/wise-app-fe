class UsersController < ApplicationController
  def new

  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to '/dashboard'
    else
      flash[:alert] = user.errors.full_messages.to_sentence
      redirect_to '/users/new'
    end
  end
end