class Industry
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name_ch
  field :name_en
  
  has_many :job_posts
  
  has_many :industries_users
#  has_many :users, :through=>:industries_users
#  has_many :interests, :through=>:industries_users

  has_and_belongs_to_many :users
  default_scope asc(:created_at)

  def self.populate
       data=File.new('db/base_data/industries.csv').lines

         data.each_with_index do |item,index| 
           Industry.create(:name_ch=>item.split("//")[0].strip,:name_en=>item.split("//")[1].strip)
         end
  end

  def to_s
    "#{name_en} #{name_ch}"
  end
end
