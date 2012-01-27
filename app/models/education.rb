class Education < ActiveRecord::Base
  attr_accessible :user_id, :school, :school_location, :degree_type, :program, :start_date, :end_date, :GPA, :comment
  validates :school, :degree_type, :program, :start_date, :end_date, :presence=>true
  belongs_to :user

#  def degree_type
#    if @is_new = true
#      ""
#    else
#      DegreeType.find(read_attribute(:degree_type)).name
#    end
#  end
end
