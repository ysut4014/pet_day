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
  end

  def index
    @posts = Post.all
    @post = Post.new  # または @post = Post.first などで最初の投稿を代入するなど
  end

  private

def post_params
  params.require(:post).permit(:title, :content, :user_id, :image)
end
end
