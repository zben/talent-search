class City < ActiveRecord::Base

  belongs_to :province
  has_many :job_posts
  has_many :users
 
  def self.populate
       City.delete_all
       data=File.new('app/models/city.csv').lines
       transaction do
         data.each do |item| 
            x = City.new(:name_ch=>item.split(",")[1].gsub(/"/,"").strip,:province_id=>item.split(",")[2].gsub(/"/,"").to_i)
            x.id=item.split(",")[0].gsub(/"/,"").to_i
            x.save
         end
       
      end
  end

end
