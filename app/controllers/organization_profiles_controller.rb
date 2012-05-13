class OrganizationProfilesController < ApplicationController
  before_filter :authenticate!
  def index
    @organization_profiles = OrganizationProfile.all
  end

  def show
    @organization_profile = OrganizationProfile.find(params[:id])
  end

  def new
    @organization_profile = OrganizationProfile.new
  end

  def create
    @organization_profile = OrganizationProfile.new(params[:organization_profile])
    if @organization_profile.save
      redirect_to @organization_profile, :notice => "Successfully created organization profile."
    else
      render :action => 'new'
    end
  end

  def edit
    @organization_profile = OrganizationProfile.find(params[:id])
  end

  def update
    @organization_profile = OrganizationProfile.find(params[:id])
    if @organization_profile.update_attributes(params[:organization_profile])
      redirect_to @organization_profile, :notice  => "Successfully updated organization profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @organization_profile = OrganizationProfile.find(params[:id])
    @organization_profile.destroy
    redirect_to organization_profiles_url, :notice => "Successfully destroyed organization profile."
  end
end
