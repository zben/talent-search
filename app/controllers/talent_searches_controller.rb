#encoding: UTF-8
class TalentSearchesController < ApplicationController
  include ApplicationHelper
  
  
  def show
    @user = current_user
    if params[:id]
      @search = TalentSearch.find(params[:id])
      @users = @search.matching_talent.page(params[:page]).per(10)
    else 
      @search = TalentSearch.new
      @is_new = true
      @users = IndUser.all
    end

  end

  def create
    @search = TalentSearch.create(params[:talent_search])
    redirect_to @search
  end

  def update
    @search = TalentSearch.create(params[:talent_search])
    redirect_to @search
  end


end
