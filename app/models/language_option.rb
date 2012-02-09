# encoding: UTF-8
class LanguageOption 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :id, type: Integer
  field :name_en
  field :name_ch
  


  def self.populate
    data = [
      {:name_en => "Mandarin Chinese", :name_ch=>"普通话（国语）"},
      {:name_en => "English", :name_ch=>"英语"},
      {:name_en => "French", :name_ch=>"法语"},
      {:name_en => "German", :name_ch=>"德语"},
      {:name_en => "Japanese", :name_ch=>"日语"},   
      {:name_en => "Other", :name_ch=>"其他"},   
    ]
    data.each{|x| self.create!(x)}
    
  end
   
end

