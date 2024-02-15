# app/controllers/public/replies_controller.rb

class Public::RepliesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(reply_params)

    respond_to do |format|
      if @reply.save
        format.html { redirect_back fallback_location: root_path, notice: 'Reply was successfully created.' }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render :show }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end


def destroy
  @comment = Comment.find(params[:comment_id])
  @reply = @comment.replies.find(params[:id])
  
  if @reply.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Reply was successfully deleted.' }
      format.json { head :no_content }
    end
  else
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, alert: 'Failed to delete reply.' }
      format.json { render json: @reply.errors, status: :unprocessable_entity }
    end
  end
end

  private

  def reply_params
    params.require(:reply).permit(:posted_text).merge(user_id: current_user.id)
  end 
end
