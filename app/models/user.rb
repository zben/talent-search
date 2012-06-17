# encoding: UTF-8
class User 
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :invitation_message

  default_scope all(sort: [[ :created_at, :desc ]])
  ## Database authenticatable
  field :email,              :type => String, :null => false
  field :encrypted_password, :type => String, :null => false
  field :admin, :type => Boolean
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :invitation_token
  field :invitation_sent_at, type: Time
  field :invitation_accepted_at, type: Time
  field :invitation_limit
  field :invited_by_id
  field :invited_by_type

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable #  :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :educations_attributes,:experiences_attributes,:exams_attributes,:languages_attributes,
    :profile_attributes,:usage_attributes,:skill_ids,:_type,
    :avatar,:logo,:chinese_resume,:english_resume,
    :org_profile_attributes, :old_password, :job_application_ids, :industry_ids

  embeds_one :profile
  embeds_one :org_profile
  embeds_one :usage
  embeds_many :educations
  embeds_many :experiences

  #  alias :orig_experiences :experiences
  #  def experiences
  #    orig_experiences.sort_by{|exp| exp.end_date || Date.today+10.years}.reverse
  #  end

  embeds_many :exams
  embeds_many :languages
  has_and_belongs_to_many :skills
  has_many :project_memberships, dependent: :destroy
  has_many :industries_users, dependent: :destroy
  has_many :job_posts, dependent: :destroy
  has_many :shouts, dependent: :destroy
  has_many :activity_feeds, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  #has_many :industries, :through=>:industries_users
  #has_many :interests,:through=>:industries_users
  has_many :tech_posts  
 
  accepts_nested_attributes_for :educations,:allow_destroy => true
  accepts_nested_attributes_for :experiences,:allow_destroy => true
  accepts_nested_attributes_for :exams,:allow_destroy => true
  accepts_nested_attributes_for :languages,:allow_destroy => true
  accepts_nested_attributes_for :profile,:allow_destroy => true
  accepts_nested_attributes_for :org_profile,:allow_destroy => true
  accepts_nested_attributes_for :usage,:allow_destroy => true

  def matches
    jobs = skills.map{|skill| skill.job_posts.current}.flatten.uniq
    jobs += industries.map{|industry| industry.job_posts.current}.flatten.uniq
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

  def bookmarked *types
    bookmarks.where(:bookmarkable_type.in=>types.to_a).map(&:bookmarkable)
  end

  def bookmarked_ids *types
    bookmarks.where(:bookmarkable_type.in=>types.to_a).map(&:bookmarkable_id)
  end

  def name
    if is_a? IndUser
      profile.try(:name) || "匿名用户"
    elsif is_a? OrgUser
      org_profile.try(:company_name) || "匿名公司"
    end  
  end

  def related_shouts including_self=true
    user_ids = bookmarked_ids('IndUser','OrgUser')
    user_ids.push(id) if including_self
    Shout.top_level.desc(:created_at).where(:user_id.in=>user_ids)
  end

  def confirm
    update_attribute(:confirmed_at,Time.now)
  end

  def projects
    project_memberships.where(:approved_at.ne=>nil).map(&:project)
  end

  def headers_for(action)
    if action == :invitation_instructions
      {:subject => "您的朋友#{self.invited_by.name}邀请你加入悟空人才网！"}
    else
      super
    end
  end
end
