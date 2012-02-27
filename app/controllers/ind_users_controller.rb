# encoding: UTF-8
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
    @user.build_profile if @user.profile.nil?
    @user.build_usage if @user.usage.nil?
    render "ind_users/edit/#{params[:info]}"
  end

  def update
    @user =  User.find(params[:id])
    if params[:ind_user][:old_password] &&！current_user.valid_password?(params[:ind_user][:old_password])
      flash[:error]="请正确输入旧密码"
      redirect_to :back
    else
      @user.update_attributes(params[:ind_user])
      if @user.save
        sign_in(@user, :bypass => true)
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
      flash[:error]="修改密码不成功。请确认你输入了同样的密码两次,您的密码有足够的复杂程度。"
        redirect_to :back
      end
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
