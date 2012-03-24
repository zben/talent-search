# encoding: UTF-8
class Language 
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid
  as_enum :language_level, :"初级"=>1, :"中级"=>2, :"流利"=>3, :"高级"=>4, :"母语"=>5
  belongs_to :language_option
  field :language_option_id, type: Integer

  attr_accessible :user_id, :language_option_id, :language_level
  validates :language_option_id, :language_level, :presence=>true
  embedded_in :user
  
  def language
    LanguageOption.find(language_option_id).name
  end

end
