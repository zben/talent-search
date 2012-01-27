# encoding: UTF-8
class DegreeType < ActiveHash::Base
  self.data = [
    {:id => 1, :name_en => "Associate", :name_ch=>"专科"},
    {:id => 2, :name_en => "Bachelor", :name_ch=>"学士"},
    {:id => 3, :name_en => "Master", :name_ch=>"硕士"},
    {:id => 4, :name_en => "Ph.D.", :name_ch=>"博士"},
    {:id => 5, :name_en => "M.D.",:name_ch=>"医学博士"},   
    {:id => 6, :name_en => "J.D.",:name_ch=>"法学博士"},   
    {:id => 7, :name_en => "Other",:name_ch=>"其他"},    
  ]
  
  
  def name
    eval("name_#{I18n.default_locale}")
  end
  
end

