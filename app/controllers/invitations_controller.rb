#encoding: UTF-8
class InvitationsController < Devise::InvitationsController
  def create
    emails = params[resource_name][:email].gsub(" ","").split(',')
    email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    current_inviter.invitation_message = params[:message]
    if emails.all?{|email| email =~ email_regex}
      emails.each{|email| resource_class.invite!({email: email}, current_inviter)}
      new_emails = emails.select{|email| User.where(:email=>email).first.encrypted_password == nil}
      old_emails = emails - new_emails
      flash[:success] = "邀请信发至: #{new_emails.join(',')}" unless new_emails.empty?
      flash[:warning] = "他们已经加入: #{old_emails.join(',')}" unless old_emails.empty?
      redirect_to :back
    elsif params[:job_post_id]
      session[:emails] = params[:user][:email]
      session[:message] = params[:message]
      redirect_to :back
    else
      flash[:error] = "Email格式有问题,请修改。"
      @emails = params[:user][:email]
      @message = params[:message]
      render :new
    end
  end

  private
  def after_invite_path_for(resource)
    new_user_invitation_path
  end
end

