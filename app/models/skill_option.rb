class LanguageOption < ActiveHash::Base
  self.data = [
    {:id => 1, :name => "PHP"},
    {:id => 2, :name => "RUBY"},
    {:id => 3, :name => "C"},
    {:id => 4, :name => "C++"},
    {:id => 5, :name => "Japanese"},   
    {:id => 6, :name => "Other"},   
  ]
end

