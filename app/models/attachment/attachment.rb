# encoding: UTF-8
class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  field :title
  belongs_to :attachable, polymorphic: true
end
