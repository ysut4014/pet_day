class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :deactivate_account]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def deactivate_account
    @user.deactivate_account
    redirect_to root_path, notice: 'ユーザーアカウントが無効化されました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_active)
  end  
end
