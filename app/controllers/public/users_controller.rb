class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # 特定のユーザーのプロフィールを表示するアクション
  def show
    @post = @user.posts.order(created_at: :desc).first # ユーザーの最新の投稿を取得
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 10) # ページネーションしてユーザーの投稿一覧を取得
  end

  # 自分自身のプロフィールを表示するアクション
  def index
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # ユーザーのプロフィールを更新するアクション
  def update
    if @user.update(user_params)
      bypass_sign_in(@user) # ログインを保持したまま更新成功時にログインし直す
      redirect_to public_user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  # ユーザーのプロフィール画像を更新する画像フォームを表示するアクション
  def edit_image
  end

  # ユーザーのプロフィール画像を更新するアクション
  def update_image
    if @user.update(profile_image_params)
      redirect_to public_user_path(@user), notice: 'プロフィール画像が更新されました。'
    else
      render :edit_image
    end
  end

  # ユーザーを削除するアクション
  def destroy
    @user.destroy
    redirect_to root_path, notice: '退会しました。またのご利用をお待ちしております。'
  end

  # 投稿やユーザーを検索するアクション
  def search
    @query = params[:query]
    @posts = Post.joins(:user).where("posts.title LIKE ? OR posts.content LIKE ? OR users.name LIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%")
                 .paginate(page: params[:page], per_page: 10)
  end

  def delete
    @user = User.find(params[:id])
  end
  
  private
  
  # リクエストされたユーザーを取得するメソッド
  def set_user
    @user = User.find(params[:id])
  end
  
  # プロフィール画像の更新に使用するストロングパラメータ
  def profile_image_params
    params.require(:user).permit(:profile_image)
  end
  
  # ユーザーのプロフィール更新に使用するストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :public_email, :profile_image)
  end
end
