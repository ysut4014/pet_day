class Public::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    public_user_path
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
end
