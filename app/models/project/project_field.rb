# encoding: UTF-8
class ProjectField
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include SimpleEnum::Mongoid

  
  field :name_ch
  field :name_en
  has_and_belongs_to_many :projects

 def self.populate
     ProjectField.destroy_all
     data=File.new('db/base_data/project_fields.csv').lines
       data.each_with_index do |item,index| 
         ProjectField.create(:name_ch=>item.split("//")[0].strip,:name_en=>item.split("//")[1].strip)
     end
  end
  
end
