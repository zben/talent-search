# encoding: UTF-8
class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include SimpleEnum::Mongoid

  
  field :name
  field :intro
          
  has_many :shouts
  belongs_to :province
  field :province_id, type: Integer
  has_many :project_membership
  as_enum :stage, :"概念"=>1,
                  :"开发初期"=>2,
                  :"产品原型"=>3,
                  :"市场化"=>4,
                  :"规模化"=>5
                  

  
  
end
