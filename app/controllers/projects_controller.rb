class ProjectsController < ApplicationController
  
  include ApplicationHelper
  before_filter :authenticate!
  
  def index
  end

  def show
    
  end

  def new
    @project = Project.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
