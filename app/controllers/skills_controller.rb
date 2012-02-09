class SkillsController < ApplicationController

  def list
      render :json=>Skill.where("name_#{I18n.locale}" => /#{params[:q]}/i)
  end
  
end
