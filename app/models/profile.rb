class Profile < ActiveRecord::Base
    
  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>" }
  validates :firstname, :lastname, :birthday, :gender, :citizenship, :residence_country,:province,
                  :intro,:intro_title, :presence=>true
                       
  belongs_to :user
  belongs_to :province
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  
  def fullname
    if lastname.size<3
    lastname+firstname
    else
    firstname+' '+lastname
    end
  end
  
  def nationality
      Country.find(citizenship).name
  end
  
  def residence
      Country.find(residence_country).name
  end
  
  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end
  

end
