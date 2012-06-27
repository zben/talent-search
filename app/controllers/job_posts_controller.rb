# encoding: UTF-8
class JobPostsController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  def index
    @user = current_user
    @job_posts = JobPost.all
  end

  def show
    @job_application = JobApplication.new
    @job_post = JobPost.find(params[:id])
    @same_industry_jobs = JobPost.current.where(:industry_id=>@job_post.industry_id).limit(6) - @job_post.to_a
    @same_company_jobs = JobPost.current.where(:user_id=>@job_post.user_id).limit(6)-@job_post.to_a
    @related_skill_jobs = @job_post.related_jobs[0..5]-@job_post.to_a
    @latest_jobs = JobPost.current.limit(5)
  end

  def new
    @user = current_user
    @job_post = JobPost.new
    @job_post.expiration = Date.today + 1.month
    if (profile = current_user.org_profile)
      @job_post.company_name = current_user.org_profile.company_name
      @job_post.industry_id=current_user.org_profile.industry_id
      @job_post.company_type=current_user.org_profile.company_type
      @job_post.contact_person = profile.contact_person
      @job_post.phone_number = profile.phone_number
      @job_post.email = profile.email
    end
  end

  def create
    @user = current_user
    @job_post = current_user.job_posts.new(params[:job_post])
    @job_post.is_official = current_user.is_a?(OrgUser)
    if @job_post.save
      update_skills(@job_post, params)
      current_user.job_posts << @job_post
      redirect_to @job_post, :notice => "成功新建职位。"
    else
      render :action => 'new'
    end
  end

  def edit
    @job_post = JobPost.find(params[:id])
    authorize! :manage, @job_post
  end

  def update
    @job_post = JobPost.find(params[:id])
    authorize! :manage, @job_post
    if @job_post.update_attributes(params[:job_post])
      update_skills(@job_post, params)
      redirect_to @job_post, :notice  => "成功更新职位。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @job_post = JobPost.find(params[:id])
    authorize! :manage, @job_post
    @job_post.destroy
    redirect_to org_user_job_posts_url(current_user), :notice => "成功删除职位"
  end
  
  def matching_talent
    @job_post = JobPost.find(params[:id])
    @users = @job_post.matches
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
  end
  
  def toggle_promo
    @job_post = JobPost.find(params[:id])
    if can? :manage, :job_posts
      if @job_post.promo_start_date.nil?
        today = Date.today
        @job_post.promo_start_date = Date.new(today.year, today.month, 1)
        @job_post.promo_end_date = Date.new(today.year, today.month + 1, 1) - 1
        @job_post.save!
      else
        @job_post.promo_start_date = nil
        @job_post.promo_end_date = nil
        @job_post.save!
      end
    end
    redirect_to :back
  end
end
