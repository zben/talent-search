class Exam < ActiveRecord::Base
  attr_accessible :user_id, :exam_name, :score, :date
end
