class Public::SessionsController < Devise::SessionsController
  private

  def after_sign_in_path_for(resource)
    flash[:notice] = "#{current_user.email} さん、ログインしました。ようこそ！"
    root_path
  end
  

  def after_sign_in_error_path_for(resource)
    flash[:alert] = "ログインに失敗しました。ユーザー名とパスワードをご確認ください。"
    new_user_session_path
  end  
end
