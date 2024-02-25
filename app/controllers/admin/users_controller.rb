# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
  before_action :authenticate_admin! # Add this if authentication is required

  def index
    @users = User.all
    @users = User.paginate(page: params[:page], per_page: 10)

  end

def show
  @user = User.find(params[:id])
  @posts = @user.posts.paginate(page: params[:page], per_page: 10)
end


  def edit
    @user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id]) # Replace 'User' with your actual user model

    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      redirect_to admin_users_path, notice: 'User was successfully updated.'

    end
  end

 

  
  private

  def user_params
    # Add your user params here
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_active)
  end  
end
