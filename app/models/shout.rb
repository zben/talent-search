class Shout
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message
  field :message_with_link
  belongs_to :user

  has_many :shouts,:dependent=>:destroy
  belongs_to :shout 
end
