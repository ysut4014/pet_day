class Public::CommentsController < ApplicationController
def create
  # フォームから送信されたコメントに関連する投稿を取得します
  @post = Post.find(params[:comment][:post_id])
  
  # コメントを作成します
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user

  # コメントが保存された場合の処理
  if @comment.save

    # 投稿の詳細ページを表示します
    redirect_to public_post_path(@post)
  else
    # コメントが保存されなかった場合は、投稿の詳細ページを再表示します
    redirect_to public_post_path(@post), alert: 'コメントの投稿に失敗しました。'
  end
end


def destroy
  @comment = Comment.find(params[:id])

  # コメントに関連する通知も削除する
  Notification.where(comment_id: @comment.id).destroy_all

  # コメントの投稿者またはコメントの関連するポストの投稿者である場合にのみ削除を許可する
  if @comment.user == current_user || @comment.post.user == current_user
    @comment.destroy
    redirect_back fallback_location: root_path, notice: 'コメントを削除しました。'
  else
    redirect_back fallback_location: root_path, alert: 'コメントを削除する権限がありません。'
  end
end



  def index
    
    @comments = Comment.all
    
    
  end
  private

def comment_params
  params.require(:comment).permit(:post_id, :posted_text) 
end
end
