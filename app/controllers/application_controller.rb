class ApplicationController < ActionController::Base
  before_action :authenticate_user!#, except: [:index]
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :check_for_tfa, except: [:devise_]

  before_action do |controller|
    Rails.logger.info('CONTROLLER')
    Rails.logger.info(controller_name)
    Rails.logger.info('ACTION')
    Rails.logger.info(action_name)
    if controller.controller_name == "sessions" && controller.action_name=="destroy"
      
    elsif controller.controller_name == "sessions" && controller.action_name=="new"

    elsif controller.controller_name == "sessions" && controller.action_name=="create"
      
    elsif controller.controller_name == "registrations" && controller.action_name=="new"
      
    elsif controller.controller_name == "registrations" && controller.action_name=="create"

    elsif controller.controller_name == "public"
      
    elsif controller.controller_name == "two_factors" # ! :devise_controller?
    else
      check_for_tfa
    end
  end

  protect_from_forgery with: :exception

  # def after_sign_in_path_for(current_user)
  #   Rails.logger.info('TESTdasddasd')
  #   Rails.logger.info(params)
  #   two_factors_new_path(params.to_unsafe_h)
  # end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def check_for_tfa
    if !session[:otp_code]
      Rails.logger.info "IN CHECK FOR TFA"
      Rails.logger.info "IN CHECK FOR TFA"
      Rails.logger.info "IN CHECK FOR TFA"
      Rails.logger.info "IN CHECK FOR TFA"
      Rails.logger.info "IN CHECK FOR TFA"
      
      redirect_to two_factors_new_path
      # return false

    else
      Rails.logger.info "IN ELSE IN ELSE"
      Rails.logger.info "IN ELSE IN ELSE"
      Rails.logger.info "IN ELSE IN ELSE"
      Rails.logger.info "IN ELSE IN ELSE"
      Rails.logger.info "IN ELSE IN ELSE"
      Rails.logger.info "IN ELSE IN ELSE"
    end
  end

end
