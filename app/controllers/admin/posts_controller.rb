# app/controllers/admin/posts_controller.rb
class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
  end

  # Other actions...
end
