class JobPostsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  def index
    @job_posts = JobPost.all
  end

  def show
    @job_post = JobPost.find(params[:id])
  end

  def new
    
    @job_post = JobPost.new
    @job_post.industry_id=current_user.org_profile.industry_id unless current_user.org_profile.nil?
  end

  def create
    @job_post = JobPost.new(params[:job_post])

    if @job_post.save
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
