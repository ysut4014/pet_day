class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :authenticate_admin!, only: [:destroy]

  # 他のアクションと同様のコード

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to public_post_path(@post), notice: 'Comment was successfully deleted.'
  end
end
