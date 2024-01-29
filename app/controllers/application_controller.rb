class ApplicationController < ActionController::Base
   before_action :authenticate_user!
  def after_sign_out_path_for(resource)
    root_path
  end
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      root_path
    else
      root_path
    end
  end
      
end
