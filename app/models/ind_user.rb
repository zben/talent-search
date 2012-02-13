class IndUser < User
    has_many :bookmarks, :foreign_key=>"user_id"
    has_many :bookmarkings, :class_name=>"Bookmark", as: :bookmarkable
#    
   
   include Mongoid::Paperclip
    if Rails.env.production?  
      has_mongoid_attached_file :avatar,
        :path => ':avatar/:id/:style.:extension',
        :default_url => '/assets/avatars/:style/missing.png',
        :storage => :s3,
        :bucket => 'talent-search',
        :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']},
        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['30x30#',   :jpg],
          :medium   => ['150x250',    :jpg],
          :large    => ['500x500>',   :jpg]
        }
    else    
      has_mongoid_attached_file :avatar,
        :default_url => '/assets/avatars/:style/missing.png',

        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['30x30#',   :jpg],
          :medium   => ['150x250',    :jpg],
          :large    => ['500x500>',   :jpg]
        }
    end


  def steps
    %w{profile education exam language experience skill} 
    #+ 
    #self.usage.attributes.select{|key,value| value==true and key!="find_money"}.keys
  end
  
  def next_step step
    steps[steps.index(step)+1]
  end
  
  def prev_step step
    steps[steps.index(step)-1]
  end

  def self.gen
   x=IndUser.create({email: Faker::Internet.email,password: 'password'})
   x.build_profile({
          firstname: Faker::Name.first_name,
          lastname: Faker::Name.last_name,
          birthday: Date.new(1990-Random.rand(20),Random.rand(11)+1,Random.rand(20)+1),
          gender_cd: Random.rand(2),
          citizenship: Random.rand(2)+1,
          residence_country: Random.rand(2)+1,
          intro: Faker::Lorem.paragraph,
          intro_title: Faker::Lorem.sentence,
          province_id: Province.all.shuffle.first.id
        })
        x.skills << Skill.all.shuffle[0..5]
        x.build_usage({find_job:true,find_project: Random.rand(2)==1,find_partner: Random.rand(2)==1, find_money: Random.rand(2)==1})
        x.save
  end
end
