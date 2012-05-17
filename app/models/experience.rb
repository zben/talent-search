class Experience 
  include Mongoid::Document
  include Mongoid::Timestamps
  default_scope all(sort: [[ :end_date, :desc ]])
  field :company_name, type: String
  field :company_location, type: String
  
  field :job_title, type: String
  field :description, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  
  attr_accessible :user_id, :industry_id, :company_name, :company_location, :job_title, :description, :start_date, :end_date
  validates :company_name, :job_title,:start_date, :industry_id, :presence=>true
  validate :start_must_be_before_end_time	
  embedded_in :user
  belongs_to :industry
  field :industry_id, type: Integer

end
