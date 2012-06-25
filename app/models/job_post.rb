# encoding: UTF-8
class JobPost 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  default_scope all(sort: [[ :created_at, :desc ]])
  scope :current, where(:expiration.gte=>Date.today)
  scope :on_promo, where(:promo_start_date.lte=>Date.today).where(:promo_end_date.gte=>Date.today)

  has_many :bookmarkings,:class_name=>"Bookmark", as: :bookmarkable

  include SimpleEnum::Mongoid
  as_enum :job_type,    :"全职"=>"1",:"兼职"=>"2", :"短期项目"=>"3", :"实习"=>"4"
  as_enum :salary, :"面议"=>"0", :"5000元以下"=>"1", :"5000元-1万元"=>"2", :"1万元-2万元"=>"3", :"2万元-3万元"=>"4", :"3万元－5万元"=>"5", :"5万元－10万元"=>"6", :"10万元以上"=>"7"
  as_enum :years_required, :"无要求"=>"1", :"1年以上"=>"2", :"3年以上"=>"3", :"5年以上"=>"4", :"10年以上"=>"5"
  as_enum :company_type, :"国企"=>"1", :"民企"=>"2", :"外企"=>"3", :"非营利组织"=>"4", :"学术研究机构"=>"5"
  as_enum :degree_requirement, :"不限"=>"0",
                        :"专科"=>"1",
                        :"学士"=>"2",
                        :"硕士"=>"3",
                        :"博士"=>"4",
                        :"医学博士"=>"5",
                        :"法学博士"=>"6"

  field :title
  field :description
  field :job_requirement
  field :company_name
  field :expiration, type: Date
  field :contact_person
  field :email
  field :phone_number
  field :logo
  field :website
  field :is_official, type: Boolean, default: true
  field :promo_start_date, type: Date
  field :promo_end_date, type: Date

  attr_accessible :title, :city_id, :province_id, :company_type, :industry_id, 
    :years_required, :years_required_cd,
    :degree_requirement, :degree_requirement_cd,
      :company_name, :company_id, :description, :job_requirement,
      :job_type, :job_type_cd, :salary, :salary_cd, :expiration, :contact_person, 
      :phone_number, :email, :logo, :website, :user_id, :skill_ids, :is_official,
      :promo_start_date, :promo_end_date

  validates :title, :company_name, :industry_id, :company_type, :province_id, :city_id,
      :description, :job_requirement, :job_type, :degree_requirement, :years_required, :salary,
      :expiration, :email, :presence=>true
  validates :email, email: true
  belongs_to :industry
  belongs_to :province
  field :province_id, type: Integer
  belongs_to :city
  field :city_id, type: Integer
  belongs_to :user
  has_and_belongs_to_many :skills
  has_many :job_applications
#  fulltext_search_in :title, :description, :job_requirement
  
  def mcount user
    (skills.to_set & user.skills.to_set).size    
  end
  
  def mcount_percent user
    percent = mcount(user)*100/skills.count
    "#{percent}%"
  end
  
  def matches
    users = skills.map{|skill| skill.users}.flatten.uniq
    users.sort!{|a,b| a.mcount(self) <=> b.mcount(self)}
  end
  
  def related_jobs
    jobs = skills.map{|skill| skill.job_posts.current}.flatten.uniq
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

  def on_promo?
    promo_start_date != nil and
    promo_end_date != nil and
    promo_start_date <= Date.today and
    promo_end_date >=Date.today
  end

end
