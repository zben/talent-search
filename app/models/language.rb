class Language < ActiveRecord::Base
  
  has_one :language_option
  has_one :language_level
  
  attr_accessible :user_id, :language_option_id, :language_level_id
  validates :language_option_id, :language_level_id, :presence=>true
  belongs_to :user
  
  def language
    LanguageOption.find(language_option_id).name
  end
  
  def language_level
    LanguageLevel.find(language_level_id).name
  end
end
