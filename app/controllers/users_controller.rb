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
  
end
