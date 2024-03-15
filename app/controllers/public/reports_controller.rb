class Public::ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:index, :show, :destroy]

  def new
    @report = Report.new
  end

def create
  @report = current_user.reports.build(report_params)
  begin
    ActiveRecord::Base.transaction do
      if @report.save
        flash[:success] = "Report submitted successfully."
        redirect_to root_path
      else
        # Handle case where report could not be saved
        flash.now[:alert] = "Failed to submit report."
        render :new
      end
    end
  rescue => e
    # Log the error for debugging
    Rails.logger.error("Error creating report: #{e.message}")
    # Provide user-friendly error message
    flash.now[:alert] = "An error occurred while submitting the report. Please try again later."
    render :new
  end
end




  def show
    @report = Report.find(params[:id])
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path, notice: "Report deleted successfully."
  end

  private

  def report_params
    params.require(:report).permit(:reported_id, :reason)
  end

  def check_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end