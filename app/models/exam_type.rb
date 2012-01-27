class ExamType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => "SAT(1600)"},
    {:id => 2, :name => "SAT(2400)"},
    {:id => 3, :name => "TOEFL(300)"},
    {:id => 4, :name => "GRE"},
    {:id => 5, :name => "GMAT"},
    {:id => 6, :name => "LSAT"},   

  ]
end

