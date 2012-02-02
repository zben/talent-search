class Country
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_ch
  field :name_en


  has_many :provinces



  
#  def self.using_object_ids?
#  false 
#  end
  
  
end

