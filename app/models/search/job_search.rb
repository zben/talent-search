class JobSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  belongs_to :industry
  field :province_id, type: Integer
  field :salary, type: Integer
  field :years_required, type: Integer
  field :keywords
  field :skills
  before_save :clean_keywords

  def matching_jobs
      job_posts = JobPost.all.current
      job_posts = job_posts.where(:industry_id=>industry_id) if industry_id.present?
      job_posts = job_posts.where(:city_id.in=>Province.find(province_id.to_i).cities.map(&:id)) if province_id.present?
      job_posts = job_posts.where(:salary_cd=>salary) if salary.present?
      job_posts = job_posts.where(:years_required_cd=>years_required) if years_required.present?
      job_posts = job_posts.any_of(
          {company_name: /#{keywords}/},
          {description: /#{keywords}/},
          {title: /#{keywords}/},
          {job_requirement: /#{keywords}/},
          {:_id.in=>
            Skill.any_of(
              {name_ch: /#{keywords}/},
              {name_en: /#{keywords}/} 
            ).map(&:job_posts).flatten.map(&:_id)
          }
          ) if keywords
      job_posts
  end

  def clean_keywords
    self.keywords = keywords.strip
  end
end
