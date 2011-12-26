class Gender < ActiveHash::Base
  self.data = [
    {:id => 1, :name => "Male"},
    {:id => 2, :name => "Female"}
  ]
end

