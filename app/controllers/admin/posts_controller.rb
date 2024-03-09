class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = if params[:search]
               search_query = "%#{params[:search]}%"
               Post.joins(:user).where('posts.title LIKE ? OR users.name LIKE ? OR posts.content LIKE ?', search_query, search_query, search_query).order(created_at: :desc)
             else
               Post.order(created_at: :desc)
             end.paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
  end  

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: '投稿が削除されました' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
