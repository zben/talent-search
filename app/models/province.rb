class Province
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name_ch
  field :name_en
  
  belongs_to :country

  has_many :cities
  

end
