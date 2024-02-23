class Public::CommentsController < ApplicationController
def create
  # フォームから送信されたコメントに関連する投稿を取得します
  @post = Post.find(params[:comment][:post_id])
  
  # コメントを作成します
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user

  # コメントが保存された場合の処理
  if @comment.save
    # 投稿に対するコメントが作成されたことを通知します
    @post.create_notification_comment!(current_user, @comment.id)

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
  
  @comment.destroy
  redirect_back fallback_location: root_path, notice: 'コメントを削除しました。'
end

  def index
    # コメントの一覧を取得するロジックをここに追加する
  end
  private

def comment_params
  params.require(:comment).permit(:post_id, :posted_text) 
end
end
