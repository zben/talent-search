# encoding: UTF-8
class ProjectMembership
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include SimpleEnum::Mongoid

  
  belongs_to :project
  belongs_to :user
   
  as_enum :role, :"管理员"=>1, :"成员"=>2
  
  field :requested_at, type: DateTime 
  field :approved_at, type: DateTime
  field :declined_at, type: DateTime
  
  
end
