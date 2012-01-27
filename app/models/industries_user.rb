class IndustriesUser < ActiveRecord::Base

  belongs_to :industry
  belongs_to :user
  belongs_to :interest
end
