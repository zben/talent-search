class Education < ActiveRecord::Base
  attr_accessible :user_id, :school, :school_location, :degree_type, :program, :start_date, :end_date, :GPA, :comment
belongs_to :user
end
