# encoding: UTF-8

# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    if params[:invitation_code]!="12345"
      flash[:error] = "悟空人才网出于测试阶段。请完整填写下列信息，包括邀请码。你也可以发信给i5kongtalent@gmail.com请求加入。"
      redirect_to :back
    else
      user = User.where(:email=>params[:user][:email]).first
      if user!=nil && user.invitation_sent_at!=nil && user.invitation_accepted_at.nil?
        redirect_to accept_user_invitation_path+"?invitation_token=#{user.invitation_token}"
      else
        super
      end
    end
  end

  def update
    super
  end
  
  def after_inactive_sign_up_path_for(resource)
    flash[:notice]= "请查收邮件"
    new_user_session_path
  end    
end 
