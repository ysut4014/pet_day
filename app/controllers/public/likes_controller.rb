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
  @like = @post.likes.build(user_id: current_user.id)
  
if @like.save
  # いいねが保存された場合の処理
  flash[:notice] = 'いいねしました'
else
  # いいねが保存されなかった場合の処理
  flash[:alert] = 'いいねに失敗しました'
end
redirect_back fallback_location: public_post_path(@post)

end




def destroy
  @post = Post.find(params[:post_id])
  like = current_user.likes.find_by(post: @post)
  like.destroy
  redirect_back fallback_location: public_posts_path
end

private

def like_params
  params.require(:like).permit(:user_id, :post_id)
end

end
