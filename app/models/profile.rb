# encoding: UTF-8
class Profile 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include SimpleEnum::Mongoid
  include Mongoid::Search

  as_enum :gender, :"女" => 1, :"男" => 0
  
  field :firstname
  field :lastname
  field :birthday, type: Date
  field :citizenship, type: Integer
  field :residence_country, type: Integer
  field :residence_state, type: Integer
  field :intro
  field :intro_title

#  has_mongoid_attached_file :avatar,
#  :styles => {
#    :original => ['1920x1680>', :jpg],
#    :thumb    => ['100x100',   :jpg],
#    :medium   => ['200x150',    :jpg]

#  }
#    

  validates :firstname, :lastname, :birthday, :gender, :citizenship, :residence_country,:province_id, :presence=>true
  #validates :intro, :intro_title, :presence=>true
  validates_length_of :firstname, :maximum => 20
  validates_length_of :lastname, :maximum => 20
  embedded_in :user
  belongs_to :province
  field :province_id, type: Integer

#  if Rails.env.production?  
#      has_mongoid_attached_file :avatar,
#        :path => ':attachment/:id/:style.:extension',
#        :storage => :s3,
#        :url => ':s3_alias_url',
#        :s3_host_alias => 'something.cloudfront.net',
#        :s3_credentials => File.join(Rails.root, 'config','s3.yml'),
#        :styles => {
#          :original => ['1920x1680>', :jpg],
#          :small    => ['100x100#',   :jpg],
#          :medium   => ['220x220>',    :jpg],
#          :large    => ['500x500>',   :jpg]
#        }
#    else    
#      has_mongoid_attached_file :avatar,
#        :styles => {
#          :original => ['1920x1680>', :jpg],
#          :small    => ['50x50#',   :jpg],
#          :medium   => ['200x150',    :jpg],
#          :large    => ['500x500>',   :jpg]
#        }
#    end
  
  def name user = nil
      fullname = (lastname || "") +(firstname || "")
      fullname.length > 5 ? (firstname|| "")+" "+(lastname||"") : fullname 
  end

  def nationality
      Country.find(citizenship).name
  end
  
  def residence
      Country.find(residence_country).name
  end
  
  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end
  

end
