class TwoFactorsController < ApplicationController
  def new
    @save_current_user = current_user.dup

    if current_user.otp_module_enabled?
      Rails.logger.info('THIS OTP MODULE IS ENABLED')
      Rails.logger.info('THIS OTP MODULE IS ENABLED')
      Rails.logger.info('THIS OTP MODULE IS ENABLED')
      Rails.logger.info('THIS OTP MODULE IS ENABLED')
    else
      session[:otp_code] = '123'
      redirect_to users_path
    end
  end

  def create
    if current_user.authenticate_otp(params[:otp_code_token], drift: 60)
      current_user.otp_module_enabled!
      session[:otp_code] = params[:otp_code_token]
      redirect_to users_path, notice: 'Two Factor Authentication Enabled'
    else
      redirect_to two_factors_new_path, alert: 'Two Factor Authentication could not be enabled'
    end
  end


end