class JobSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  field :industry_id, type: Integer
  field :city_id, type: Integer 
  field :min_salary, type: Integer
  field :max_salary, type: Integer
  field :keywords
  field :skills
end
