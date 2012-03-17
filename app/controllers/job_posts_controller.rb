# encoding: UTF-8
class JobPostsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  def index
    @job_posts = JobPost.all
  end

  def show
    @job_post = JobPost.find(params[:id])
    @same_industry_jobs = JobPost.current.where(:industry_id=>@job_post.industry_id).limit(6) - @job_post.to_a
    @same_company_jobs = JobPost.current.where(:user_id=>@job_post.user_id).limit(6)-@job_post.to_a
    @related_skill_jobs = @job_post.related_jobs[0..5]-@job_post.to_a
    @latest_jobs = JobPost.current.limit(5)
  end

  def new
    
    @job_post = JobPost.new
    @job_post.company_name = current_user.org_profile.company_name unless current_user.org_profile.nil?
    @job_post.industry_id=current_user.org_profile.industry_id unless current_user.org_profile.nil?
  end

  def create
    @job_post = JobPost.new(params[:job_post])

    if @job_post.save
      update_skills(@job_post, params)
      current_user.job_posts << @job_post
      
      redirect_to @job_post, :notice => "Successfully created job post."
    else
      render :action => 'new'
    end
  end

  def edit
    @job_post = JobPost.find(params[:id])
    @provinces=Province.all
  end

  def update
    @job_post = JobPost.find(params[:id])
    
    if @job_post.update_attributes(params[:job_post])
      update_skills(@job_post, params)
      redirect_to @job_post, :notice  => "Successfully updated job post."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @job_post = JobPost.find(params[:id])
    @job_post.destroy
    redirect_to job_posts_url, :notice => "Successfully destroyed job post."
  end
  

end
