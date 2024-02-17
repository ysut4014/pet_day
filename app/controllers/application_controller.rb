class ApplicationController < ActionController::Base
 before_action :check_user_status
def after_sign_in_path_for(resource)
  case resource
  when Admin
    flash[:notice] = "ログインに成功しました。"
    admin_root_path
  when Customer
    flash[:notice] = "ログインに成功しました。"
    root_path
  else
    flash[:notice] = "ログインに成功しました。"
    root_path
  end
end

  private

  def check_user_status
    if current_user && !current_user.active?
      sign_out current_user
      redirect_to root_path, alert: "アカウントが無効化されています。"

    end
  end
      
end
