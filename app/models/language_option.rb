# encoding: UTF-8
class LanguageOption 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :id, type: Integer
  field :name_en
  field :name_ch
  
  has_many :languages

  def self.populate
    data = [
      {:id => 1, :name_en => "Mandarin Chinese", :name_ch=>"普通话（国语）"},
      {:id => 2, :name_en => "English", :name_ch=>"英语"},
      {:id => 3, :name_en => "French", :name_ch=>"法语"},
      {:id => 4, :name_en => "German", :name_ch=>"德语"},
      {:id => 5, :name_en => "Japanese", :name_ch=>"日语"},   
      {:id => 6, :name_en => "Other", :name_ch=>"其他"},   
    ]
    data.each{|x| self.create!(x)}
    
  end
   
end

