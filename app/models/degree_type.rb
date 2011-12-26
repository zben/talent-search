class DegreeType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => "Associate"},
    {:id => 2, :name => "Bachelor"},
    {:id => 3, :name => "Master"},
    {:id => 4, :name => "PhD"},
    {:id => 5, :name => "MD"},   
    {:id => 6, :name => "JD"},   
    {:id => 7, :name => "Other"},    
  ]
end

