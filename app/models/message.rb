# encoding: UTF-8
class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title , type: String
  field :content ,type: String
  belongs_to :user #message receiver
  belongs_to :sender, :class_name => "User",:foreign_key => "sender_id"
  
 end
