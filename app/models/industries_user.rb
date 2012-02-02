class IndustriesUser
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :industry
  belongs_to :user
  belongs_to :interest
end
