class User 
  include Mongoid::Document
  include Mongoid::Timestamps
  
 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
   
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :educations_attributes,:experiences_attributes,:exams_attributes,:languages_attributes,
                  :profile_attributes,:usage_attributes,:skill_ids,:_type,:avatar,:logo,:org_profile_attributes

  embeds_one :profile
  embeds_one :org_profile
  embeds_one :usage
  embeds_many :educations
  embeds_many :experiences
  embeds_many :exams
  embeds_many :languages
  has_and_belongs_to_many :skills
 
  has_many :industries_users
  has_many :job_posts
  #has_many :industries, :through=>:industries_users
  #has_many :interests,:through=>:industries_users
  
 
  accepts_nested_attributes_for :educations,:allow_destroy => true
  accepts_nested_attributes_for :experiences,:allow_destroy => true
  accepts_nested_attributes_for :exams,:allow_destroy => true
  accepts_nested_attributes_for :languages,:allow_destroy => true
  accepts_nested_attributes_for :profile,:allow_destroy => true
  accepts_nested_attributes_for :org_profile,:allow_destroy => true
  accepts_nested_attributes_for :usage,:allow_destroy => true
  
  
  
  def matches
    jobs = skills.map{|skill| skill.job_posts}.flatten.uniq
    jobs.sort!{|a,b| a.mcount(self) <=> b.mcount(self)}
  end
  
  def mcount job
    (skills.to_set & job.skills.to_set).size    
  end

  def interested_industries interest_type
    industries_users.where(:interest_id=>Interest.where(:name_ch=>interest_type)[0].id).map{|x| x.industry}
  end
  
  def set_interested_industries(interest_type, industries)
    IndustriesUser.where(:user_id=>self.id, :interest_id=>Interest.where(:name_ch=>interest_type)[0].id).destroy_all
    industries.each{|x| x.industries_users.create(:user_id=>self.id,:interest_id=>Interest.where(:name_ch=>interest_type)[0].id)}
  end
 
   def bookmarked type
     bookmarks.where(:bookmarkable_type=>type).map(&:bookmarkable)
   end
  
end
