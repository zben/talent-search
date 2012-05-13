#encoding: UTF-8
class MessagesController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  
  def new 
  end
  
  def create 
    @recipient = User.find(params[:message][:user_id])
    @content = params[:message][:content]
    UserMailer.message_user(current_user, @recipient, @content).deliver
    flash[:success] = "邮件发送成功"
    redirect_to :back
  end

end
