# encoding: UTF-8

class Gender < ActiveHash::Base
  include ActiveHash::Associations
  has_many :profiles
  self.data = [
    {:id => 1, :name_en => "Male",:name_ch=>"男"},
    {:id => 2, :name_en => "Female",:name_ch=>"女"}
  ]
  
  def name
    eval("name_#{I18n.default_locale}")
  end
  
end

