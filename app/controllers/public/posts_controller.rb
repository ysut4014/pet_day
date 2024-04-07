class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def new
    @post = Post.new
  end

  # 新しい投稿を作成するためのアクション
  def create
    @post = Post.new(post_params)
    if @post.save
      create_notifications_for_followers(@post) # 新しい投稿をフォロワーに通知
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to root_path, alert: "他のユーザーの投稿を編集する権限がありません。"
    end    
    
  end  

  # 特定の投稿を表示するためのアクション
  def show
    @post = Post.find(params[:id])
    @post.update(viewed: true) unless @post.viewed # 投稿が閲覧されたことを更新
    @comments = @post.comments.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
   if current_user
     @reported_id = current_user.id
     @reported_name = current_user.name
   end
  end    

  # 投稿の一覧を表示するためのアクション
  def index
    if params[:search].present?
      @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end
  end

  # 投稿を削除するためのアクション
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
    
    
  end  
  
  # ユーザーをフォローするためのアクション
  def follow
    @user = User.find(params[:id])
    current_user.followees << @user unless current_user.followees.include?(@user)
    redirect_to @user
  end

  # ユーザーのフォローを解除するためのアクション
  def unfollow
    @user = User.find(params[:id])
    current_user.followees.delete(@user)
    redirect_to @user
  end  

  private

  # フォームから送信された投稿データを受け取るためのストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :image)
  end

  # フォロワーに新しい投稿の通知を作成するためのメソッド
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
