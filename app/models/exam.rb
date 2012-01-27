class Exam < ActiveRecord::Base
  attr_accessible :user_id, :exam_name, :score, :date
  validates :exam_name, :score, :date, :presence=>true
  belongs_to :user
  
  def name
    ExamType.find(exam_name).name
  end
end
