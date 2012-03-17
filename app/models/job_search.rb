class JobSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  field :industry_id, type: Integer
  field :province_id, type: Integer 
  field :salary, type: Integer
  field :years_required, type: Integer
  field :keywords
  field :skills
  
  def matching_jobs
      job_posts = JobPost.all
      job_posts = job_posts.where(:industry_id=>industry_id) if industry_id.present?
      job_posts = job_posts.where(:city_id.in=>Province.find(province_id.to_i).cities.map(&:id)) if province_id.present?
      job_posts = job_posts.where(:salary_cd=>salary) if salary.present?
      job_posts = job_posts.where(:years_required_cd=>years_required) if years_required.present?
      
      unless keywords.blank?
        job_posts = job_posts.any_of(
          {description: /#{@search.keywords}/},
          {title: /#{@search.keywords}/},
          {job_requirement: /#{@search.keywords}/},
          {:_id.in=>
            Skill.any_of(
              {name_ch: /#{@search.keywords}/},
              {name_en: /#{@search.keywords}/} 
            ).map(&:job_posts).flatten.map(&:_id)
          }
          )
      end
      return job_posts
  end
  
end
