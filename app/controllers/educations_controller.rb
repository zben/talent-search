class EducationsController < ApplicationController
  before_filter :authenticate!
  def new
    @education = Education.new
  end

  def create
    @education = Education.new(params[:education])
    if @education.save
      redirect_to root_url, :notice => "Successfully created education."
    else
      render :action => 'new'
    end
  end
end
