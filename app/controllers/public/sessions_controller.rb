# app/controllers/public/sessions_controller.rb
class Public::SessionsController < Devise::SessionsController
  private

  def after_sign_in_path_for(resource)
    root_path
  end
end
