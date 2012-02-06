class IndUsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def index
    @ind_ind_users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  
  def new 
    @user = User.find(params[:id])
    @user.build_profile if @user.profile.nil?
    @user.build_usage if @user.usage.nil?
    @is_new = true
    render "ind_users/edit/#{params[:info]}"
  end
 
  
  def edit
    @user = User.find(params[:id])
    render "ind_users/edit/#{params[:info]}"
  end

  def update
    @user =  User.find(params[:id])
    @user.update_attributes(params[:ind_user])
    if @user.save
      logger.info params[:ind_user]
      remove_avatar(@user) unless params["remove_avatar"].nil?
      update_skills(@user,params) unless params[:skills].nil?
      next_step = params[:current_step].nil? ? nil : @user.next_step(params[:current_step])   
      if next_step.nil?
        redirect_to @user
      else
        @is_new = true
        redirect_to ind_user_new_path(@user.id,"#{next_step}")
      end
    else
      redirect_to :back
    end
  end
  
  def bookmarked_users
      @users = current_user.bookmarked("IndUser")
  end
  
  def bookmarked_companies
      @companies = current_user.bookmarked("OrgUser")
  end
  
  def bookmarked_jobs
    @job_posts = current_user.bookmarked("JobPost")
  end
  
  
  def job_posts 
    @user = User.find(params[:id])  
    @job_posts = JobPost.where(:user_id=>params[:id])
  end
 
end
