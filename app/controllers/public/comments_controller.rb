class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:comment][:post_id])  # フォームから送信されたコメントに関連する投稿を取得します
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      render 'public/posts/show'
    else
      render 'public/posts/show'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back fallback_location: root_path, notice: 'コメントを削除しました。'
  end
  private

def comment_params
  params.require(:comment).permit(:post_id, :posted_text) 
end
end
