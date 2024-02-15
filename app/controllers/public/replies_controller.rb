# app/controllers/public/replies_controller.rb

class Public::RepliesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(reply_params)

    if @reply.save
      redirect_to @post, notice: 'Reply was successfully created.'
    else
      # エラー処理
    end
  end
  def destroy
    # 返信の削除ロジック
  end
  
  private

  def reply_params
    params.require(:reply).permit(:posted_text)
  end  
end
