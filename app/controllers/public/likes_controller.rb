class Public::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]

  def index
    @likes = current_user.likes.includes(:post).order(created_at: :desc).paginate(page: params[:page], per_page: 30)
  end
  
  def create
    @like = @post.likes.build(user_id: current_user.id)
  
    if @like.save
      flash[:notice] = 'いいねしました。'
    else
      flash[:alert] = 'いいねに失敗しました。'
    end
    redirect_back fallback_location: public_post_path(@post)
  end
  
  def destroy
    like = current_user.likes.find_by(post: @post)
    like.destroy
    flash[:notice] = 'いいねを取り消しました。'
    redirect_back fallback_location: public_post_path(@post)
  end

  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
end
