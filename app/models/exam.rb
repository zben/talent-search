class Exam 
  include Mongoid::Document
  include Mongoid::Timestamps
  default_scope all(sort: [[ :end_date, :desc ]])
  field :exam_name
  field :score, type: Integer
  field :max_score, type: Integer
  field :date, type: Date
  
  attr_accessible :user_id, :exam_name, :score, :max_score, :date
  validates :exam_name, :date, :presence=>true
  embedded_in :user
  
  def name
    ExamType.find(exam_name).name
  end
end
