#encoding: UTF-8
class UsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def index
    @users = User.all
  end
  
#  def show
#    @user = User.find(params[:id])
#    render :profile
#  end
  
  def new 
    @user = User.find(params[:id])
    @is_new = true
    redirect_to ind_user_new_path(params[:id],params[:info]) if current_user.is_a? IndUser
    redirect_to org_user_new_path(params[:id],params[:info]) if current_user.is_a? OrgUser
  end
 
  
  def edit
    @user = User.find(params[:id])
    redirect_to ind_user_edit_path(params[:id],params[:info]) if current_user.is_a? IndUser
    redirect_to org_user_edit_path(params[:id],params[:info]) if current_user.is_a? OrgUser
  end


  
  def update
    @user =  User.find(params[:id])

    if @user.update_attributes(params[:user])
      remove_avatar(@user) unless params["remove_avatar"].nil?
      update_skills(@user,params) unless params[:skills].nil?
      if params[:user][:next_step]
        redirect_to user_new_path(params[:id],params[:user][:next_step])
      else
        flash[:notice]= t("update successful")
        @is_new = true
        render :template=>"users/edit/#{params[:user][:this_step]}"
      end
    else
      render :template=>"users/edit/#{params[:user][:this_step]}"
    end
  end
  
  def profile
    redirect_to current_user
  end
  
  def update_email_or_password
    @user = User.find(params[:id]) 
    if current_user.valid_password?(params["#{@user.class.name.underscore}"][:old_password]) == false
      flash[:error] = "请正确输入旧密码"
      redirect_to :back
    elsif @user.update_attributes(params["#{@user.class.name.underscore}"])
      redirect_to @user
    else
      flash[:error] = "修改密码不成功。请确认你输入了同样的密码两次而且您的密码有足够的复杂程度。"
      redirect_to :back
    end

  end
  
  
end
