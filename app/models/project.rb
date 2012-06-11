# encoding: UTF-8
class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include SimpleEnum::Mongoid

  field :title
  field :one_liner
  field :intro
  field :project_update
  field :video_code
  has_many :shouts
  has_many :photos, autosave: true, as: :attachable
  has_many :bookmarkings,:class_name=>"Bookmark", as: :bookmarkable
  has_one :download, autosave: true, as: :attachable
  has_and_belongs_to_many :project_fields
  has_and_belongs_to_many :project_needs

  field :people_count, type: Integer

  belongs_to :province
  field :province_id, type: Integer
  has_many :project_memberships
  as_enum :stage, :"概念"=>1,
                  :"开发初期"=>2,
                  :"产品原型"=>3,
                  :"市场化"=>4,
                  :"规模化"=>5
  as_enum :visibility, :"公开" =>"1", :"只给关注的人公开"=>"2", :"隐藏"=>"3"
  as_enum :has_patent, :"有"=>"1", :"无"=>"2", :"申请中"=>"3"
  scope :public, where(visibility_cd: "1")

    if Rails.env.production?  
      has_mongoid_attached_file :logo,
        :path => ':project_logo/:id/:style.:extension',
        :default_url => '/assets/project_logo/:style/missing.jpg',
        :storage => :s3,
        :bucket => 'talent-search',
        :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']},
        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['30x30#',   :jpg],
          :medium   => ['150x100',    :jpg],
          :large    => ['400x300>',   :jpg]
        }
    else
      has_mongoid_attached_file :logo,
        :default_url => '/assets/project_logo/:style/missing.jpg',
        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['30x30#',   :jpg],
          :medium   => ['150x100',    :jpg],
          :large    => ['400x300>',   :jpg]
        }
    end
    
  attr_accessible :title, :video_code, :download, :one_liner, :intro, :visibility, :logo, :province_id, :stage, :has_patent, :photos_attributes, :people_count, :project_need_ids, :project_field_ids
  validates :people_count, :one_liner, :visibility, :title, :intro, :province,:province_id, :stage, :presence =>true
  validates_presence_of :project_field_ids
  validates_numericality_of :people_count, :only_integer=>true, :greater_than=>0

  accepts_nested_attributes_for :photos, :allow_destroy => true
  
  def add_admin user
    membership = project_memberships.find_or_initialize_by(:user_id=>user.id)
    membership.role_cd= 1
    membership.requested_at = membership.approved_at = Time.now
    membership.save!
  end

  
  def admins
    project_memberships.where(role_cd: 1).map(&:user)
  end
  
  def all_members
    project_memberships.where(:approved_at.ne=>nil).map(&:user)
  end
  
  def pending_applications
    project_memberships.where(approved_at: nil).where(declined_at: nil)
    
  end

   
  def quit user
    project_memberships.where(:user_id=>user.id).destroy_all 
  end
  
  def new_application user
    project_memberships.create!(user_id: user.id, role_cd: 2, requested_at: Time.now)
  end
  
  def status user
    memberships = project_memberships.where(:user_id=>user.id)
    if memberships.empty?
        'new'
    elsif memberships[0].approved_at.nil? && memberships[0].declined_at.nil?
        'pending'
    elsif memberships[0].approved_at.nil? && !memberships[0].declined_at.nil?
        'declined'
    elsif memberships[0].role_cd == 2
        'member'
    else
        'admin'
    end
  end
end
