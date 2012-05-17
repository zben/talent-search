class ProjectSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  field :province_id, type: Integer
  belongs_to :project_field
  field :has_patent, type: Boolean
  field :stage_cd
  field :keywords, type: String

  def matching_projects
      projects= Project.all
      projects= project_field.projects unless project_field.blank?
      projects= projects.where(:province_id => province_id) unless province_id.blank?
      projects= projects.where(has_patent: has_patent) unless has_patent.blank? 
      projects= projects.where(stage_cd: stage_cd.to_i) unless stage_cd.blank?
      projects= projects.any_of(
        {"title"=> /#{keywords}/},
        {"intro"=> /#{keywords}/},
      ) unless keywords.blank?
      projects
  end
end
