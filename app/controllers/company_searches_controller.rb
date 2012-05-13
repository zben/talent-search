#encoding: UTF-8
class CompanySearchesController < ApplicationController
  include ApplicationHelper
  
  before_filter :authenticate!
  
  def show
    @user = current_user
    if params[:id]
      @search = CompanySearch.find(params[:id]) 
      @users = Kaminari.paginate_array(@search.matching_companies).page(params[:page]).per(10)
    else 
      @search = CompanySearch.new
      @is_new = true
      @users = OrgUser.with_org_profile.page(params[:page]).per(10)
    end

  end

  def create
    @search = CompanySearch.create(params[:company_search])
    redirect_to @search
  end

  def update
    @search = CompanySearch.find(params[:id])
    @search.update_attributes(params[:company_search])
    redirect_to @search
  end


end
