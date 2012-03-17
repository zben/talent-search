class OrgUsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def index
    @users = OrgUser.all.with_org_profile.page(params[:page]).per(10)
  end
  
  def show
    @user = OrgUser.find(params[:id])

  end
  
  def new 
    @user = OrgUser.find(params[:id])
    @user.build_org_profile if @user.org_profile.nil?
    @is_new = true
    render "org_users/edit/#{params[:info]}"
  end
 
  
  def edit
    @user = User.find(params[:id])
    render "org_users/edit/#{params[:info]}"
  end

  def update
    @user =  OrgUser.find(params[:id])
    @user.update_attributes(params[:org_user])
    if @user.save
      remove_avatar(@user) unless params["remove_avatar"].nil?
      update_skills(@user,params) unless params[:skills].nil?
      next_step = params[:current_step].nil? ? nil : @user.next_step(params[:current_step])   
      if next_step.nil?
        redirect_to @user
      else
        @is_new = true
        redirect_to org_user_new_path(@user.id,"#{next_step}")
      end
    else
      redirect_to :back
    end
  end
  

  
  def job_posts 
    @user = User.find(params[:id])  
    @job_posts = JobPost.where(:user_id=>params[:id])
  end
  
  def bookmarked_users
      @users = current_user.bookmarked("IndUser")
  end
  
end
