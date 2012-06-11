# encoding: UTF-8
class ProjectsController < ApplicationController

  include ApplicationHelper
  before_filter :authenticate!

  def index
    if params[:search_id]
      @search = ProjectSearch.find(params[:search_id])
      @projects = Kaminari.paginate_array(@search.matching_projects).page(params[:page]).per(10)
    else
      @search = ProjectSearch.new
      @projects = Project.public.page(params[:page]).per(10)
    end
  end

  def overview
    @latest_projects = Project.limit(10)
    @latest_project_shouts = Shout.where(:project_id.in => current_user.bookmarked_ids("Project")).limit(10)
  end

  def search
    @search = ProjectSearch.create(params[:project_search])
    redirect_to projects_list_path(@search.id)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @project.visibility = :"公开"
    5.times{@project.photos.build}
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      @project.add_admin current_user
      redirect_to @project
    else
      (5-@project.photos.count).times{@project.photos.build}
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    unless @project.admins.include?(current_user) || current_user.admin
      redirect_to root_url
    end
    (5-@project.photos.count).times{@project.photos.build}
  end

  def update
    @project = Project.find(params[:id])
    if !@project.admins.include?(current_user) && !current_user.admin?
      redirect_to root_url
    elsif @project.update_attributes(params[:project])
      redirect_to @project
    else
      flash[:notice]="请修改下列错误再提交"
      (5-@project.photos.count).times{@project.photos.build}
      render :edit
    end
  end

  def destroy
  end

  def apply
    @project= Project.find(params[:id])
    @project.new_application current_user
    flash[:success]="您的申请已递交，请等待项目负责人审批"
    redirect_to :back
  end
  
  def quit
    @project= Project.find(params[:id])
    @project.quit current_user
    flash[:notice]="取消申请成功"
    redirect_to :back
  end
  
  def approve
    @application = ProjectMembership.find(params[:id])  
    @application.approved_at = Time.now
    @application.save!
    redirect_to :back
  end
  
  def decline
    @application = ProjectMembership.find(params[:id])  
    @application.declined_at = Time.now
    @application.save!
    redirect_to :back
  end

  def shouts
    @project = Project.find(params[:id])
    @shouts = @project.shouts.page(params[:page]).per(10) 
  end
end
