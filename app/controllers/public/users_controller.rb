# app/controllers/public/users_controller.rb
class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show] 

  def show
    @user = User.find(params[:id])
  end
  
  def index
    @user = current_user
    @posts = @user.posts
  end  
end
