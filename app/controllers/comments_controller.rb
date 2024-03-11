class CommentsController < ApplicationController
  def index
    @comments = Comment.all.order(created_at: :desc).page(params[:page]).per(10)
  end
end