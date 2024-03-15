class Admin::ReportsController < ApplicationController
  def index
    @reports = Report.all
  end  
  
def new
  @reported_user = User.find(params[:user_id]) # 通報対象のユーザーを見つける
  @report = Report.new # 新しい通報オブジェクトを作成する
end
  
def create
  @report = Report.new(report_params)
  @report.user = current_user

  if @report.save
    flash[:success] = "通報が送信されました。"
    redirect_to root_path # 通報が成功した場合のリダイレクト先を設定します
  else
    flash.now[:error] = "通報の送信に失敗しました。"
    render :new # 通報が失敗した場合、再び通報フォームを表示します
  end
end

  
  private

  def report_params
    params.require(:report).permit(:reported_id, :reason)
  end  
    
end
