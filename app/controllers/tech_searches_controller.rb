#encoding: UTF-8
class TechSearchesController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate!
  
  
  def show
    @user = current_user
    if params[:id]
      @search = TechSearch.find(params[:id]) 
      @tech_posts = Kaminari.paginate_array(@search.matching_techs).page(params[:page]).per(10)
    else
      @search = TechSearch.new
      @is_new = true
      @tech_posts = TechPost.page(params[:page]).per(10)
    end

  end

  def create
    @search = TechSearch.create(params[:tech_search])
    redirect_to @search
  end

  def update
    @search = TechSearch.create(params[:tech_search])
    redirect_to @search
  end


end
