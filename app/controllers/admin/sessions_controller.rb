# app/controllers/admin/sessions_controller.rb
class Admin::SessionsController < Devise::SessionsController
  private

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
end