class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post: @post)
    redirect_back fallback_location: public_posts_path, notice: 'いいねしました！'
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy
    redirect_back fallback_location: public_posts_path, notice: 'いいねを解除しました！'
  end
end
