class Public::RegistrationsController < ApplicationController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @resource = User.new 
    @resource_name = :user
  end
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
  end  
end