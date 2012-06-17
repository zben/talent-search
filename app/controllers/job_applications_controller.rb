# encoding: UTF-8
class JobApplicationsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def create
    @job_post = JobPost.find(params[:job_application][:job_post_id])
    @content = params[:job_application][:content]
    @application = JobApplication.new(params[:job_application].merge(:user_id=>current_user.id))
    if @application.save
      UserMailer.apply_for_job(current_user,@job_post,@content).deliver
      flash[:success] = "职位申请成功。"
      redirect_to :back
    else
      flash[:failure] = "申请不成功，请重试。"
      redirect_to :back 
    end
  end

  def destroy
    @job_application = JobApplication.find(params[:id])
    @job_application.destroy
    flash[:success] = "撤销申请成功"
    redirect_to :back
  end




end
