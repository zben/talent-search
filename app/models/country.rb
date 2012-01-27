class Country < ActiveYaml::Base

  include ActiveHash::Associations
  has_many :citizens, :class_name=>"Profile",:foreign_key=>'citizenship'
  has_many :residents, :class_name=>"Profile",:foreign_key=>'residence_country'
  set_root_path "app/models"
#  self.data = [
#    {:id => 1, :name => "China"},
#    {:id => 2, :name => "United States"}
#  ]

  def name
    eval("name_#{I18n.default_locale}")
  end
end

