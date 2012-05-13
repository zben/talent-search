class ProfilesController < ApplicationController
  before_filter :authenticate!
  def new
    redirect_to user_new_path(current_user.id,'profile')
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      redirect_to user_new_path(current_user.id,'education'), :notice => "Successfully created profile."
    else
      render :action => 'new'
    end
  end
  
  def update
    @profile = User.find(params[:id]).profile
    @profile.update_attributes(params[:profile])
    if @profile.save
      redirect_to :back, :notice => "Successfully updated profile."
    else
      redirect_to :back
    end
  end

end
