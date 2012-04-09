class Shout
  include Mongoid::Document
  include Mongoid::Timestamps
  scope :top_level, where(:shout_id=>nil)
  default_scope all(sort: [[ :created_at, :desc ]])
  field :message
  field :message_with_link
  belongs_to :project
  belongs_to :user

  has_many :shouts,:dependent=>:destroy
  belongs_to :shout 
  

end
