# encoding: UTF-8
class ProjectNeed
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include SimpleEnum::Mongoid

  
  field :name_ch
  field :name_en
  has_and_belongs_to_many :projects
end
