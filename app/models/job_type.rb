# encoding: UTF-8

class JobType < ActiveHash::Base
  include ActiveHash::Associations
  has_many :job_posts
  
  self.data = [
    {:id => 1, :name_en => "Full-time",:name_ch=>"全职"},
    {:id => 2, :name_en => "Part-time",:name_ch=>"兼职"},
    {:id => 3, :name_en => "Short-term project",:name_ch=>"短期项目"},
  ]
  
  def name
    eval("name_#{I18n.default_locale}")
  end
  
end

