class Public::LikesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @likes = current_user.likes.includes(:post).paginate(page: params[:page], per_page: 10)
  end
  
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user_id: current_user.id)
  
    if @like.save
      flash[:notice] = 'いいねしました。'
    else
      flash[:alert] = 'いいねに失敗しました。'
    end
    redirect_back fallback_location: public_post_path(@post)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy
    flash[:notice] = 'いいねを取り消しました。'
    redirect_back fallback_location: public_post_path(@post)
  end
end
