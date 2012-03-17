class SkillsController < ApplicationController

  def list
      render :json=>Skill.where("name_#{I18n.locale}" => /#{params[:q]}/i)
  end
  
  def users 
    @skill = Skill.find(params[:id])
    @users = @skill.users
  end
  
  def job_posts
    @skill = Skill.find(params[:id])
    @users = @skill.job_posts
  end
  
  def companies 
  end
  
end
