class ExperiencesController < ApplicationController
  before_filter :authenticate!
  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(params[:experience])
    if @experience.save
      redirect_to root_url, :notice => "Successfully created experience."
    else
      render :action => 'new'
    end
  end
end
