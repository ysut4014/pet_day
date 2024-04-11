class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :show, :update, :destroy]

  # 新規投稿フォームを表示するアクション
  def new
    @post = current_user.posts.build
  end

  # 新規投稿を作成するアクション
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      create_notifications_for_followers(@post) # フォロワーに通知を作成
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  # 投稿の編集フォームを表示するアクション
  def edit
    redirect_to root_path, alert: "他のユーザーの投稿を編集する権限がありません。" unless @post.user == current_user
  end  

  # 特定の投稿を表示するアクション
  def show
    @post.update(viewed: true) unless @post.viewed
    @comments = @post.comments.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
    @reported_id = current_user.id if current_user # ログインユーザーのID
    @reported_name = current_user.name if current_user # ログインユーザーの名前
  end    

  # 投稿の一覧を表示するアクション
  def index
    @posts = if params[:search].present?
               Post.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
                   .order(created_at: :desc)
                   .paginate(page: params[:page], per_page: 10)
             else
               Post.all.order(created_at: :desc)
                   .paginate(page: params[:page], per_page: 10)
             end
  end

  # 投稿を削除するアクション
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  # 投稿を更新するアクション
  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end  
  
  # ユーザーをフォローするアクション
  def follow
    @user = User.find(params[:id])
    current_user.followees << @user unless current_user.followees.include?(@user)
    redirect_to @user
  end

  # フォローを解除するアクション
  def unfollow
    @user = User.find(params[:id])
    current_user.followees.delete(@user)
    redirect_to @user
  end  

  private

  # 特定の投稿をセットアップするメソッド
  def set_post
    @post = Post.find(params[:id])
  end

  # 投稿パラメータを取得するストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :image)
  end

  # フォロワーに新規投稿の通知を作成するメソッド
  def create_notifications_for_followers(post)
    followers = post.user.followers
    followers.each do |follower|
      Notification.create(
        visitor_id: post.user_id,
        visited_id: follower.id,
        post_id: post.id,
        action: 'new_post'
      )
    end
  end
end
