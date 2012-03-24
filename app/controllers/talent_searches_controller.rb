#encoding: UTF-8
class TalentSearchesController < ApplicationController
  include ApplicationHelper
  
  
  def show
    @user = current_user
    if params[:id]
      @search = TalentSearch.find(params[:id]) 
      @users = IndUser.with_ind_profile
      @users = @users.where("profile.birthday"=>{'$lte'=>Time.now - @search.min_age.to_i.years}) if @search.min_age
      
      @users = @users.where("profile.birthday"=>{'$gte'=>Time.now - @search.max_age.to_i.years})  if @search.max_age
      @users = @users.any_of(
        {"profile.intro"=> /#{@search.keywords}/},
        {"profile.intro_title"=> /#{@search.keywords}/}
      ) if @search.keywords
    else 
      @search = TalentSearch.new
      @is_new = true
      @users = @user.matching_talent
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
