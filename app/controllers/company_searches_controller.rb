#encoding: UTF-8
class CompanySearchesController < ApplicationController
  include ApplicationHelper
  
  
  def show
    @user = current_user
    if params[:id]
      @search = CompanySearch.find(params[:id]) 
      @users = OrgUser.with_org_profile
      @users = @users.where("org_profile.people_count_cd"=>@search.people_count) if @search.people_count
      @users = @users.where("org_profile.industry_id"=>@search.industry_id) if @search.industry_id
      @users = @users.where("org_profile.city_id"=>@search.city_id) if (@search.city_id && @search.province_id)
      @users = @users.any_of(
        {"org_profile.company_name"=> /#{@search.keywords}/},
        {"org_profile.short_description"=> /#{@search.keywords}/},
        {"org_profile.long_description"=> /#{@search.keywords}/}
      ) if @search.keywords
    else 
      @search = CompanySearch.new
      @is_new = true
      @users = OrgUser.with_org_profile
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
