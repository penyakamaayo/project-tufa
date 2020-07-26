class AppController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @users = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :admin)
  end
end