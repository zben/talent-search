# encoding: UTF-8
class TechPostsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  def index
    @user = current_user
    @tech_posts = TechPost.all.where(:user_id=>@user._id);
  end

  def show
    # @job_application = JobApplication.new
    @tech_post = TechPost.find(params[:id])
    # @same_industry_jobs = JobPost.current.where(:industry_id=>@job_post.industry_id).limit(6) - @job_post.to_a
    @same_company_techs = TechPost.current.where(:user_id=>@tech_post.user_id).limit(6)-@tech_post.to_a
    @latest_techs = TechPost.current.limit(5)
    @user=current_user
  end

  def new
    @user = current_user
    @tech_post = TechPost.new
    @tech_post.expiration = Date.today + 3.month
    if (profile = current_user.org_profile)
      @tech_post.company_name = current_user.org_profile.company_name
      @tech_post.contact_person = profile.contact_person
      @tech_post.phone_number = profile.phone_number
      @tech_post.email = profile.email
    end
  end

  def create
    @user = current_user
    @tech_post = current_user.tech_posts.new(params[:tech_post])
    @tech_post.expiration = Date.today + 3.month
    
    if (profile = current_user.org_profile)
     @tech_post.company_name = current_user.org_profile.company_name
    end
    
    if @tech_post.save!
      current_user.tech_posts << @tech_post
      redirect_to @tech_post, :notice => "成功发布技术需求。"
    else
      render :action => 'new'
    end
  end

  def edit
    @tech_post = TechPost.find(params[:id])
    authorize! :manage, @tech_post
  end

  def update
    @tech_post = TechPost.find(params[:id])
    authorize! :manage, @tech_post
    if @tech_post.update_attributes(params[:tech_post])
      redirect_to @tech_post, :notice  => "成功更新技术需求。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @tech_post = TechPost.find(params[:id])
    authorize! :manage, @tech_post
    @tech_post.destroy
    redirect_to tech_posts_path, :notice => "成功删除技术需求"
  end
  
  

end
