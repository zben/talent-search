class Province < ActiveRecord::Base

  belongs_to :country
  has_many :profiles
  has_many :cities
  
  
  def self.populate
       Province.delete_all
       data=File.new('app/models/province.csv').lines
       transaction do
         data.each do |item| 
            x = Province.new(:name_ch=>item.split(",")[1].gsub(/"/,"").strip,:country_id=>1)
            x.id=item.split(",")[0].gsub(/"/,"").to_i
            x.save
         end
       
      end
  end

end
