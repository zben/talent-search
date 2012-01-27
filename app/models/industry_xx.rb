class Industry < ActiveFile::Base
  include ActiveHash::Associations
  has_many :job_posts
  has_and_belongs_to_many :users
  
  set_root_path "app/models"
  set_filename "industry"

  class << self
    def extension
      "csv"
    end

    def load_file
#       MyAwesomeDecoder.load_file(full_path)
       data=File.new(full_path).lines
       data.map{|item| 
          {
            
            :name_ch=>item.split("//")[0].strip,
            :name_en=>item.split("//")[1].strip,
          }
       }
    end
  end
  
  def name
    eval("name_#{I18n.default_locale}")
  end
end
