# encoding: UTF-8

class LanguageLevel < ActiveHash::Base
  include ActiveHash::Associations
  belongs_to :language
  self.data = [
    {:id => 1, :name_en => "beginner",:name_ch=>"初级"},
    {:id => 2, :name_en => "intermediate",:name_ch=>"中级"},
    {:id => 3, :name_en => "fluent",:name_ch=>"流利"},
    {:id => 4, :name_en => "advanced",:name_ch=>"高级"},
    {:id => 5, :name_en => "native",:name_ch=>"母语"},  
  ]
  
  def name
    eval("name_#{I18n.default_locale}")
  end
end

