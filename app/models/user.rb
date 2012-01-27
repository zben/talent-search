class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :educations_attributes,:experiences_attributes,:exams_attributes,:languages_attributes,
                  :profile_attributes,:usage_attributes,:skill_ids,:type_id

  has_one :profile
  has_one :usage
  has_many :educations
  has_many :experiences
  has_many :exams
  has_many :languages
  has_and_belongs_to_many :skills
 
  has_many :industries_users
  has_many :industries, :through=>:industries_users
  has_many :interests,:through=>:industries_users
  
  accepts_nested_attributes_for :educations,:allow_destroy => true
  accepts_nested_attributes_for :experiences,:allow_destroy => true
  accepts_nested_attributes_for :exams,:allow_destroy => true
  accepts_nested_attributes_for :languages,:allow_destroy => true
  accepts_nested_attributes_for :profile,:allow_destroy => true
  accepts_nested_attributes_for :usage,:allow_destroy => true
  
  def matches
    jobs = skills.map{|skill| skill.job_posts}.flatten.uniq
    jobs.sort!{|a,b| a.mcount(self) <=> b.mcount(self)}
  end
  
  def mcount job
    (skills.to_set & job.skills.to_set).size    
  end

    
end
