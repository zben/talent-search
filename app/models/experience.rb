class Experience < ActiveRecord::Base
  attr_accessible :user_id, :company_name, :company_location, :job_title, :description, :start_date, :end_date
  belongs_to :user
end
