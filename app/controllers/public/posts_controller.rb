class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end


def create
  @post = Post.new(post_params)
  if @post.save
    # 新しい投稿を作成したユーザーのフォロワーに通知を作成
    @post.user.followers.each do |follower|
      follower.notifications.create(
        message: "新しい投稿があります",
        action: "new_post",
        post_id: @post.id
      )
    end
    redirect_to public_posts_path
  else
    render 'new'
  end
end

  def show
    @post = Post.find(params[:id])
    @post.update(viewed: true) unless @post.viewed
  end    


def index
  if params[:search].present?
    @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  else
    @posts = Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end
end


  
  def follow
    @user = User.find(params[:id])
    current_user.followees << @user unless current_user.followees.include?(@user)
    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followees.delete(@user)
    redirect_to @user
  end  

  private

def post_params
  params.require(:post).permit(:title, :content, :user_id, :image)
end

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
