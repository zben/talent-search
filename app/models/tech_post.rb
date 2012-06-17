# encoding: UTF-8
class TechPost 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  default_scope all(sort: [[ :created_at, :desc ]])
  scope :current, where(:expiration.gte=>Date.today)
  has_many :bookmarkings,:class_name=>"Bookmark", as: :bookmarkable
  has_many :tech_applications
  include SimpleEnum::Mongoid
  as_enum :company_type, :"国企"=>1, :"民企"=>2, :"外企"=>3, :"非营利组织"=>4, :"学术研究机构"=>5
  as_enum :co_type, :"技术引进"=>1, :"合作开发"=>2 , :"合作创办企业"=>3

  field :title
  field :description
  field :company_name
  field :expiration, type: Date
  field :contact_person
  field :compensation
  field :email
  field :phone_number
  has_and_belongs_to_many :project_fields 
  attr_accessible :title, :company_type, :industry_id,
      :company_name, :company_id, :description, 
       :compensation, :expiration, :contact_person, 
      :phone_number, :email, :website, :user_id, :project_field_ids, :co_type, :province_id  
  validates :title, :description , :email , :province_id , :co_type , :compensation , :presence=>true 
  #:description, :expiration, :email, :province_id ,:presence=>true
  validates :email, email: true
  belongs_to :user
  belongs_to :province
  field :province_id, type: Integer

  def self.populate
    #TechPost.delete_all
    #data = get_csv_data 'db/base_data/tech_posts.csv'

     # data.each do |post|
     # end
  end

  def get_application(user)
    TechApplication.where(tech_post_id: self.id, user_id: user.id).first
  end

end
