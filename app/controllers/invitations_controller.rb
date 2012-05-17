#encoding: UTF-8
class InvitationsController < Devise::InvitationsController
  def create
    emails = params[resource_name][:email].gsub(" ","").split(',')
    email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    if emails.all?{|email| email =~ email_regex}
      emails.each{|email| resource_class.invite!({email: email}, current_inviter)}
      set_flash_message :success, :send_instructions, :email => emails.join(",")
      respond_with resource, :location => after_invite_path_for(resource)
    else
      flash[:error]= "Email格式有问题,请修改。"
      @emails = params[:user][:email]
      render :new
    end
  end

  private
  def after_invite_path_for(resource)
    new_user_invitation_path
  end
end

