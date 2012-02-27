#encoding: UTF-8
class JobSearchesController < ApplicationController
  include ApplicationHelper
  
  
  def show
    @user = current_user
    if params[:id]
      @search = JobSearch.find(params[:id]) 
      job_posts = JobPost.all
      job_posts = job_posts.where(:industry_id=>@search.industry_id) if @search.industry_id.present?
      job_posts = job_posts.where(:city_id.in=>Province.find(@search.province_id.to_i).cities.map(&:id)) if @search.province_id.present?
      job_posts = job_posts.where(:salary.gte=>@search.min_salary) if @search.min_salary.present?
      job_posts = job_posts.where(:salary.lte=>@search.max_salary) if @search.max_salary.present?
      unless @search.keywords.blank?
        @job_posts = job_posts.any_of(
          {description: /#{@search.keywords}/},
          {title: /#{@search.keywords}/},
          {job_requirement: /#{@search.keywords}/},
          {:_id.in=>
            Skill.any_of(
              {name_ch: /#{@search.keywords}/},
              {name_en: /#{@search.keywords}/} 
            ).map(&:job_posts).flatten.map(&:_id)
          }
          )
      end
    else 
      @search = JobSearch.new
      @is_new = true
      @job_posts = @user.matches
    end

  end

  def create
    @search = JobSearch.create(params[:job_search])
    redirect_to @search
  end

  def update
    @search = JobSearch.create(params[:job_search])
    redirect_to @search
  end


end
