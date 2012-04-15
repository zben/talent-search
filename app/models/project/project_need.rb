# encoding: UTF-8
class ProjectNeed
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include SimpleEnum::Mongoid

  
  field :name_ch
  field :name_en
  has_and_belongs_to_many :projects

  def self.populate
    ProjectNeed.destroy_all
    self.create(:name_ch=>"投资人",:name_en=>"Investors")
    self.create(:name_ch=>"招聘人才",:name_en=>"Employees")
    self.create(:name_ch=>"合伙人",:name_en=>"Core team members")
  end
end
