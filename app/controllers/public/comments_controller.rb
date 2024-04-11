class Public::CommentsController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:destroy]

  # コメントを投稿するアクション
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントを投稿しました。'
    else
      redirect_to post_path(@post), alert: 'コメントの投稿に失敗しました。'
    end
  end

  # コメントを削除するアクション
  def destroy
    unless current_user_can_delete?
      redirect_back fallback_location: root_path, alert: 'コメントを削除する権限がありません。'
      return
    end

    @comment.destroy
    redirect_back fallback_location: root_path, notice: 'コメントを削除しました。'
  end

  # 全てのコメントを一覧表示するアクション
  def index
    @comments = Comment.all
  end

  private

  # 投稿を設定するメソッド
  def set_post
    @post = Post.find_by(id: params[:comment][:post_id])
    redirect_back fallback_location: root_path, alert: '投稿が見つかりません。' unless @post
  end

  # コメントを設定するメソッド
  def set_comment
    @comment = Comment.find_by(id: params[:id])
    redirect_back fallback_location: root_path, alert: 'コメントが見つかりません。' unless @comment
  end

  # コメントの投稿者または投稿者の投稿であるかを確認するメソッド
  def current_user_can_delete?
    @comment.user == current_user || @comment.post.user == current_user
  end

  # コメントのパラメーターを取得するメソッド
  def comment_params
    params.require(:comment).permit(:post_id, :posted_text)
  end
end
