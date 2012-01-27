class Experience < ActiveRecord::Base
  attr_accessible :user_id, :company_name, :company_location, :job_title, :description, :start_date, :end_date
  validates :company_name, :job_title,:start_date, :presence=>true
  belongs_to :user
end
