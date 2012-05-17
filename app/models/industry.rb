class Industry
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :id, type: Integer
  field :name_ch
  field :name_en
  
  has_many :job_posts
  
  has_many :industries_users
#  has_many :users, :through=>:industries_users
#  has_many :interests, :through=>:industries_users
  
  def self.populate
       data=File.new('db/base_data/industries.csv').lines

         data.each_with_index do |item,index| 
           Industry.create(:id=>index,:name_ch=>item.split("//")[0].strip,:name_en=>item.split("//")[1].strip)
         end
  end

  def to_s
    "#{name_en} #{name_ch}"
  end
end
