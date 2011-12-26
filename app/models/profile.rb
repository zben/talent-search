class Profile < ActiveRecord::Base
  
    
  attr_accessible :user_id, :firstname, :lastname, :birthday, :gender, :citizenship, :residence_country
  
  belongs_to :user
  
  def fullname
    lastname+firstname
  end
  
  def nationality
      Country.find(citizenship).name
  end
  
  def residence
      Country.find(residence_country).name
  end
  
end
