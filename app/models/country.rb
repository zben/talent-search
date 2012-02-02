class Country
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_ch
  field :name_en
   
  has_many :citizens, :class_name=>"Profile",:foreign_key=>'citizenship'
  has_many :residents, :class_name=>"Profile",:foreign_key=>'residence_country'
  has_many :provinces



  
#  def self.using_object_ids?
#  false 
#  end
  
  
end

