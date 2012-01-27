class Industry < ActiveRecord::Base
  has_many :job_posts
  has_and_belongs_to_many :users
  
  has_many :industries_users
  has_many :users, :through=>:industries_users
  has_many :interests, :through=>:industries_users
  
  def self.populate
       data=File.new('app/models/industry.csv').lines
       transaction do
         data.each do |item| 
            
           Industry.create(:name_ch=>item.split("//")[0].strip,:name_en=>item.split("//")[1].strip)
          
         end
       
      end
  end
 

end
