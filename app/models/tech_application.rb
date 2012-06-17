# encoding: UTF-8
class TechApplication 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper
  include SimpleEnum::Mongoid

  belongs_to :user
  belongs_to :tech_post
  field :content
  as_enum :status, :"重点关注"=>1,
                   :"后备关注"=>2,
                   :"忽略"=>3,
                   :"待审"=>4


end

