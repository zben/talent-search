class OrgUser < User
  include Mongoid::Paperclip
    has_many :bookmarks, :foreign_key=>"user_id"
    has_many :bookmarkings, :class_name=>"Bookmark", as: :bookmarkable

    has_many :bookmarks, :foreign_key=>"user_id"   

    scope :with_org_profile, where(:org_profile.ne=>nil) 
    delegate :name, to: :org_profile
    if Rails.env.production?  
      has_mongoid_attached_file :logo,
        :path => ':logo/:id/:style.:extension',
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
      has_mongoid_attached_file :logo,
        :default_url => '/assets/logo/:style/missing.jpg',
        :styles => {
        :original => ['1920x1680>', :jpg],
        :small    => ['30x30#',   :jpg],
        :medium   => ['150x250',    :jpg],
        :large    => ['500x500>',   :jpg]
      }
    end

    def steps
      %w{profile} 
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
      x=OrgUser.create({email: Faker::Internet.email,password: 'password'})
      x.build_org_profile({
        name: Faker::Lorem.sentence.upcase,
        short_description: Faker::Lorem.sentences(4),
        long_description: Faker::Lorem.paragraphs(4),
        people_count: Random.rand(400),
        contact_person: Faker::Name.name,
        email: Faker::Internet.email,
        phone_number: "86-132928372",
        city_id: City.all.shuffle.first.id,
        industry_id: Industry.all.shuffle.first.id
      })
      x.skills << Skill.all.shuffle[0..5]
      x.save!
    end

    def matching_talent
      skills.map{|skill| skill.users}.flatten.uniq.sort!{|a,b| a.mcount(self)<=>b.mcount(self)}
    end

    def avatar *args
      logo *args
    end
end
