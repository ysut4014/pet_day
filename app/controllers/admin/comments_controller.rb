class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_comment, only: [:destroy]

  def destroy
    @comment.destroy
    redirect_to admin_post_path(@comment.post), notice: 'コメントが削除されました。'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end