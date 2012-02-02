# encoding: UTF-8
class Interest
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :industries_users
#  has_many :industries, :through=>:industries_users
#  has_many :users, :through=>:industries_users
  
  def self.populate
    Interest.create(:name_ch=>"求职",:name_en=>"Jobs")
    Interest.create(:name_ch=>"找短期任务",:name_en=>"Projects")
    Interest.create(:name_ch=>"创业",:name_en=>"Entrepreneurship") 
  end
end
