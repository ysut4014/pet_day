class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
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
    @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end
  @post = Post.new  
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
end
