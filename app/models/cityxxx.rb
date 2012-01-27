class City < ActiveFile::Base
  include ActiveHash::Associations
  belongs_to :province
  has_many :job_posts
  set_root_path "app/models"
  set_filename "city"

  def name
    eval("name_#{I18n.default_locale}")
  end
  
  class << self
    def extension
      "csv"
    end

    def load_file
#       MyAwesomeDecoder.load_file(full_path)
       data=File.new(full_path).lines
       data.map{|item| 
          {
            :id=>item.split(",")[0].gsub(/"/,"").to_i,
            :name_ch=>item.split(",")[1].gsub(/"/,"").strip,
            :province_id=>item.split(",")[2].gsub(/"/,"").to_i,
          }
       }
    end
  end
end
