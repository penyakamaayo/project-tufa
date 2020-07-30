# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   # User = warden.authenticate!(auth_options)
  #   # set_flash_message!(:notice, :signed_in)
  #   # sign_in(resource_name, user)
  #   # yield user if block_given?
  #   # respond_with user, location: after_sign_in_path_for(user)
  #   # super && signed_in?
  #   # redirect_to(users_path) and return
  #   # sign_out(@user)
  #   # Rails.logger.info "session: #{session}"
  # end

    
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  # def auth_options
  #   { scope: resource_name, recall: "#{controller_path}#new" }
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource && resource.admin_allow_tfa?
      continue_to_otp(resource, resource_name)
    elsif #resource && resource.admin_allow_tfa?
      continue_sign_in(resource, resource_name)
    end
  end

  private
    def continue_sign_in(resource, resource_name)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      resource.logins.create!(ip_address: request.remote_ip, user_agent: request.user_agent, last_sign_in: resource.current_sign_in_at, username: resource.username, email: resource.email)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    def continue_to_otp(resource, resource_name)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: two_factors_new_path(params.to_unsafe_h)
  end
end
