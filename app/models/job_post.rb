# encoding: UTF-8
class JobPost 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper
  has_many :bookmarkings,:class_name=>"Bookmark", as: :bookmarkable
  
  include SimpleEnum::Mongoid
  as_enum :job_type,    :"全职"=>1,:"兼职"=>2, :"短期项目"=>3

#  as_enum :years_required, :"无要求" => 0, :"1年以上" => 1, :"2年以上" => 2, :"3年以上" => 3, :"5年以上" => 5, :"10年以上" => 10
  field :years_required, type: Integer
  field :title
  field :description
  field :job_requirement
  field :company_name
  field :salary, type: Integer
  field :expiration, type: Date
  field :contact_person
  field :email
  field :phone_number
  field :logo
  field :website
  field :is_official, type: Boolean, default: true
  
  attr_accessible :title, :city_id, :industry_id, :years_required, 
      :company_name, :company_id, :description, :job_requirement, 
      :job_type, :salary, :expiration, :contact_person, 
      :phone_number, :email, :logo, :website, :user_id, :skill_ids, :is_official
  
  validates :title, :city_id,
      #:description, :job_requirement, 
      :job_type_cd,  :expiration, :email, :presence=>true
      
  belongs_to :industry
  belongs_to :city
  field :city_id, type: Integer
  belongs_to :user
  has_and_belongs_to_many :skills
  
#  fulltext_search_in :title, :description, :job_requirement
  
  def mcount user
    (skills.to_set & user.skills.to_set).size    
  end
  
  def matches
    users = skills.map{|skill| skill.users}.flatten.uniq
    users.sort!{|a,b| a.mcount(self) <=> b.mcount(self)}
  end
  
  def related_jobs
    jobs = skills.map{|skill| skill.job_posts}.flatten.uniq
    jobs.sort!{|a,b| mcount(a) <=> mcount(b)}
  end
  
  

  def self.populate
    JobPost.delete_all
    data = get_csv_data 'db/base_data/job_posts.csv'

      data.each do |post|
        city = City.where(:name_ch => /#{post['city_id']}/) 
        city = City.where(:name_ch => /其他/) if city.empty?
        post["job_type_cd"]=post["job_type_cd"].to_i
        post["industry_id"]=post["industry_id"].to_i
        puts city[0].name
        puts post
        JobPost.create(post.merge({"city_id"=>city[0].id })
        )
      end
  end
  

end
