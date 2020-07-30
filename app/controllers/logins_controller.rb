class LoginsController < ApplicationController
  before_action :set_user
  before_action :set_logins

  def index
  end

  def set_user
    user_id = if current_user.admin?
                params[:user_id] || current_user.id
              else
                current_user.id
              end

    @user = User.find(user_id)
  end

  def set_logins
    @logins=@user.logins
  end
end