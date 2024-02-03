class Public::LikesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.find(params[:post_id])
    @likes = @post.likes.includes(:user)
    @likes = current_user.likes.includes(:post)
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post: @post)
    redirect_back fallback_location: public_posts_path
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy
    redirect_back fallback_location: public_posts_path
  end
end
