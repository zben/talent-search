class Exam 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :exam_name
  field :score, type: Integer
  field :date, type: Date
  
  attr_accessible :user_id, :exam_name, :score, :date
  validates :exam_name, :score, :date, :presence=>true
  embedded_in :user
  
  def name
    ExamType.find(exam_name).name
  end
end
