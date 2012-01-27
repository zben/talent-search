class JobPostsController < ApplicationController
  include ApplicationHelper
  def index
    @job_posts = JobPost.all
  end

  def show
    @job_post = JobPost.find(params[:id])
  end

  def new
    @job_post = JobPost.new
  end

  def create
    @job_post = JobPost.new(params[:job_post])

    if @job_post.save
      params[:as_values_skills].split(",").each do |skill_id|
          @job_post.skills << Skill.find(skill_id)
      end

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
  
  def skills
      render :json=>Skill.where("name_#{I18n.locale} LIKE '%#{params[:q]}%'")
      
  end
end
