# encoding: UTF-8
class Photo < Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip


  if Rails.env.production?  
    has_mongoid_attached_file :photo,
      :path => ':photo/:id/:style.:extension',
      :storage => :s3,
      :bucket => 'talent-search',
      :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']},
      :styles => {
      :original => ['1920x1680>', :jpg],
      :thumb    => ['100x100',   :jpg],
      :medium   => ['200x150',    :jpg],
      :large =>['400x300>', :jpg]
    }
  else
    has_mongoid_attached_file :photo,
      :default_url => '/assets/photo/:style/missing.jpg',
      :styles => {
      :original => ['1920x1680>', :jpg],
      :thumb    => ['100x100',   :jpg],
      :medium   => ['200x150',    :jpg],
      :large =>['400x300>', :jpg]
    }
  end


end
