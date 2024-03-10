class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def after_sign_up_path_for(resource)
    root_path
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user  # 新規登録後に自動的にログインする
      redirect_to root_path, notice: '新規登録が完了しました。'
    else
      if @user.errors.messages[:email].include?("has already been taken")
        flash.now[:alert] = 'そのメールアドレスはすでに登録されています。別のメールアドレスを使用してください。'
      else
        flash.now[:alert] = '新規登録に失敗しました。入力内容をご確認ください。'
      end
      render :new
    end
  end 

  protected

def configure_sign_up_params
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :public_email])
end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
