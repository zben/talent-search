#encoding: UTF-8
class JobSearchesController < ApplicationController
  include ApplicationHelper
  def show
    @search = JobSearch.find(params[:id]) || JobSearch.new
    job_posts = JobPost.all
    job_posts = job_posts.where(:industry_id=>@search.industry_id) if @search.industry_id.present?
    job_posts = job_posts.where(:city_id=>@search.city_id) if @search.city_id.present?
    job_posts = job_posts.where(:salary.gte=>@search.min_salary) if @search.min_salary.present?
    job_posts = job_posts.where(:salary.lte=>@search.max_salary) if @search.max_salary.present?
    @job_posts = job_posts.any_of({description: /#{@search.keywords}/},{title: /#{@search.keywords}/},{job_requirement: /#{@search.keywords}/})
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
