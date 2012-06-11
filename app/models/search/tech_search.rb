class TechSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  belongs_to :project_field
  field :province_id, type: Integer 
  field :keywords
  field :co_type_cd, type: Integer

     

  before_save :clean_keywords

  def matching_techs
      tech_posts = TechPost.all.current
      tech_posts = project_field.tech_posts unless project_field.blank?

      tech_posts = tech_posts.where(:co_type_cd=>co_type_cd) if co_type_cd.present?
      tech_posts = tech_posts.any_of(
          {company_name: /#{keywords}/},
          {description: /#{keywords}/},
          {title: /#{keywords}/},
          {compensation: /#{keywords}/},
          ) if keywords
      tech_posts
  end

  def clean_keywords
    self.keywords = keywords.strip
  end
end
