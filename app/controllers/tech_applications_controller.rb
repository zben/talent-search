# encoding: UTF-8
class TechApplicationsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def create
    @tech_post = TechPost.find(params[:tech_application][:tech_post_id])
    @content = params[:tech_application][:content]
    @application = TechApplication.new(params[:tech_application].merge(:user_id=>current_user.id))
    if @application.save
      UserMailer.apply_for_tech(current_user,@tech_post,@content).deliver
      flash[:success] = "项目需求申请成功。"
      redirect_to :back
    else
      flash[:failure] = "申请不成功，请重试。"
      redirect_to :back 
    end
  end

  def destroy
    @tech_application = TechApplication.find(params[:id])
    @tech_application.destroy
    flash[:success] = "撤销申请成功"
    redirect_to :back
  end




end

