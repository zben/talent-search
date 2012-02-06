class TalentSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper


  field :min_age, type: Integer
  field :max_age, type: Integer
  field :keywords
  field :skills
end
