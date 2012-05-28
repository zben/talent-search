class Park
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_many :photos, autosave: true, as: :attachable
  has_many :downloads, autosave: true, as: :attachable
  field :name_ch
  field :short_intro
  field :long_intro
  field :contact_person
  field :email
  field :phone_number
  accepts_nested_attributes_for :photos, :allow_destroy => true
  accepts_nested_attributes_for :downloads, :allow_destroy => true

  belongs_to :province
  field :province_id, type: Integer
  belongs_to :city
  field :city_id, type: Integer
  validates_presence_of :name_ch, :province_id, :city_id
  if Rails.env.production?  
      has_mongoid_attached_file :logo,
        :path => ':park_logo/:id/:style.:extension',
        :storage => :s3,
        :bucket => 'talent-search',
        :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']},
        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['30x30#',   :jpg],
          :medium   => ['150x100',    :jpg],
          :large    => ['400x300>',   :jpg]
        }
    else
      has_mongoid_attached_file :logo,
        :default_url => '/assets/park_logo/:style/missing.jpg',
        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['30x30#',   :jpg],
          :medium   => ['150x100',    :jpg],
          :large    => ['400x300>',   :jpg]
        }
    end
end
