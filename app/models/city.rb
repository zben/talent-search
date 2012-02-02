class City 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name_ch
  field :name_en
   
  belongs_to :province
  has_many :job_posts
  has_many :users
 
  def fullname
    province.name+" "+name
  end

end
