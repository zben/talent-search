# encoding: UTF-8
class IndUsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  def index
    @ind_users = IndUser.with_profile.page(params[:page]).per(10)
  end
  
  def profile
    @user = User.find(params[:id])
  end
  
  def show 
    @user = params[:id].nil? ? current_user : User.find(params[:id])
    render :profile if @user != current_user
    @ind_activity_feeds = ActivityFeed.feed_for(current_user,'IndUser').limit(10)
    @org_activity_feeds = ActivityFeed.feed_for(current_user,'OrgUser').limit(10)
    @matching_jobs = current_user.matches[0..10] 
    @status_update = current_user.related_shouts.limit(10)
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
    @user.update_attributes(params[:ind_user])
    if @user.save
      sign_in(@user, :bypass => true)
      logger.info params[:ind_user]
      remove_avatar(@user) unless params["remove_avatar"].nil?
      update_skills(@user,params) unless params[:skills].nil?
      next_step = params[:is_new].nil? ? nil : @user.next_step(params[:current_step])   
      if next_step.nil?
        redirect_to ind_user_profile_path(@user)
      else
        @is_new = true
        redirect_to ind_user_new_path(@user.id,"#{next_step}")
      end
    else
      params[:is_new].nil? ? 
        render(:template=>"ind_users/edit/#{params[:current_step]}") :
        render(:template=>"ind_users/new/#{params[:current_step]}")
    end
  end
  

  def bookmarked_users
      @user = current_user
      @users = Kaminari.paginate_array(current_user.bookmarked("IndUser").compact).page(params[:page]).per(10)
  end
  
  def bookmarked_companies
  
      @user = current_user
      @companies = Kaminari.paginate_array(current_user.bookmarked("OrgUser").compact).page(params[:page]).per(10)
  end
  
  def bookmarked_jobs
    @user = current_user
    @job_posts = current_user.bookmarked("JobPost").compact.page(params[:page]).per(10)
  end

  def job_posts 
    @user = User.find(params[:id])  
    @job_posts = JobPost.where(:user_id=>params[:id]).page(params[:page]).per(10)
  end

  
 
end
