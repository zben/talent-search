# encoding: UTF-8
class Download < Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip


  if Rails.env.production?
    has_mongoid_attached_file :download,
      :path => ':download/:id/:file_name',
      :storage => :s3,
      :bucket => 'talent-search',
      :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']}
  else
    has_mongoid_attached_file :download
  end
end

