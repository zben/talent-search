class CompanySearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  field :province_id, type: Integer
  field :city_id, type: Integer
  field :people_count, type: Integer
  field :industry_id, type: Integer
  field :keywords, type: String
end
