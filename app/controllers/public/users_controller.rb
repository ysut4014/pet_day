# app/controllers/public/users_controller.rb
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
  
  def edit
    # 編集処理を実装する
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
    # ユーザーに関連するレコードを削除
    @user.posts.destroy_all
    @user.comments.destroy_all
    # 他にも削除すべき関連レコードがあれば追加する

    # ユーザーを削除
    @user.destroy

    redirect_to root_path, notice: 'アカウントが削除されました。'
  end  
def deactivate
  @user = User.find(params[:id])
  @user.update(is_active: false)
  redirect_to root_path, notice: 'アカウントが無効化されました。'
end

  def search
    @query = params[:query]
    @posts = Post.joins(:user).where("posts.title LIKE ? OR posts.content LIKE ? OR users.name LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%").paginate(page: params[:page], per_page: 10)
  end
  
 private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :public_email)
  end
end
