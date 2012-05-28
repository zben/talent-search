#encoding: UTF-8
class ParkSearchesController < ApplicationController
  include ApplicationHelper
  
  before_filter :authenticate!
  
  def show
    @user = current_user
    if params[:id]
      @search = ParkSearch.find(params[:id]) 
      @parks = Kaminari.paginate_array(@search.matching_parks).page(params[:page]).per(10)
    else 
      @search = ParkSearch.new
      @is_new = true
      @parks = Park.page(params[:page]).per(10)
    end

  end

  def create
    @search = ParkSearch.create(params[:park_search])
    redirect_to @search
  end

  def update
    @search = ParkSearch.find(params[:id])
    @search.update_attributes(params[:park_search])
    redirect_to @search
  end


end

