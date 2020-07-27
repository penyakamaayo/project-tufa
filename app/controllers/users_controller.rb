class UsersController < ApplicationController

  def enable_otp user_id=params[:user_id] || current_user.id
    user=User.find user_id
    user.otp_secret = User.generate_otp_secret
    user.otp_required_for_login = true
    user.save!
    redirect_to users_path
  end 
  
  def disable_otp user_id=params[:user_id] || current_user.id
    user = User.find user_id
    user.otp_required_for_login = false
    user.save!
    redirect_to users_path
  end

  def index
    @users = User.all
    if Rails.env.production?
      @country = request.location.country
      @city = request.location.city
      @coordinates = request.location.coordinates
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])

    # if @user.update(user_params)
    #   redirect_to users_path
    # else
    #   render 'edit'
    # end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :admin)
  end
end