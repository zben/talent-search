class Country < ActiveHash::Base

  include ActiveHash::Associations
  has_many :citizens, :class_name=>"Profile",:foreign_key=>'citizenship'
  has_many :residents, :class_name=>"Profile",:foreign_key=>'residence_country'
  
  self.data = [
    {:id => 1, :name => "China"},
    {:id => 2, :name => "United States"}
  ]
end

