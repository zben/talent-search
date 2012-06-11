class OrgUser < User
  include Mongoid::Paperclip
    has_many :bookmarks, :foreign_key=>"user_id"
    has_many :bookmarkings, :class_name=>"Bookmark", as: :bookmarkable

    has_many :bookmarks, :foreign_key=>"user_id"
  accepts_nested_attributes_for :educations,:allow_destroy => true
  accepts_nested_attributes_for :experiences,:allow_destroy => true
  accepts_nested_attributes_for :exams,:allow_destroy => true
  accepts_nested_attributes_for :languages,:allow_destroy => true
  accepts_nested_attributes_for :profile,:allow_destroy => true
  accepts_nested_attributes_for :org_profile,:allow_destroy => true
  accepts_nested_attributes_for :usage,:allow_destroy => true

    scope :with_org_profile, where(:org_profile.ne=>nil)
    if Rails.env.production?  
      has_mongoid_attached_file :logo,
        :path => ':logo/:id/:style.:extension',
        :default_url => "/assets/logo/:style/missing.jpg",
        :storage => :s3,
        :bucket => 'talent-search',
        :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']},
        :styles => {
        :original => ['1920x1680>', :jpg],
        :small    => ['40x40#',   :jpg],
        :medium   => ['150x100',    :jpg],
        :large    => ['400x300>',   :jpg]
      }
    else    
      has_mongoid_attached_file :logo,
        :default_url => '/assets/logo/:style/missing.jpg',
        :styles => {
        :original => ['1920x1680>', :jpg],
        :small    => ['40x40#',   :jpg],
        :medium   => ['150x100',    :jpg],
        :large    => ['400x300>',   :jpg]
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
