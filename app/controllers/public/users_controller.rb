class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :delete]

  def show
    @user = User.find(params[:id])
    @post = @user.posts.order(created_at: :desc).first
        @posts = @user.posts.paginate(page: params[:page], per_page: 10)

    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def index
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end
  

  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end
  
def destroy
  @user = current_user

  # ユーザーに関連するコメントを削除
 # @user.comments.destroy_all

  # ユーザーに関連する投稿を削除
  #@user.posts.destroy_all

  # ユーザーを削除
  @user.destroy

  redirect_to root_path, notice: '退会しました。またのご利用をお待ちしております。'
end


  def search
    @query = params[:query]
    @posts = Post.joins(:user).where("posts.title LIKE ? OR posts.content LIKE ? OR users.name LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%").paginate(page: params[:page], per_page: 10)
    @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
 
  end
  
 private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :public_email)
  end
end
