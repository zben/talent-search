class SkillCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name_en
  field :name_ch
  
  has_many :skills
end
