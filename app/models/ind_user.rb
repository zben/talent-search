class IndUser < User
    include Mongoid::BasicSearch
    has_many :bookmarks, :foreign_key=>"user_id"
    has_many :bookmarkings, :class_name=>"Bookmark", as: :bookmarkable
    has_many :tech_applications
    has_and_belongs_to_many :industries
    scope :with_ind_profile, where(:profile.ne=>nil)

  accepts_nested_attributes_for :educations,:allow_destroy => true
  accepts_nested_attributes_for :experiences,:allow_destroy => true
  accepts_nested_attributes_for :exams,:allow_destroy => true
  accepts_nested_attributes_for :languages,:allow_destroy => true
  accepts_nested_attributes_for :profile,:allow_destroy => true
  accepts_nested_attributes_for :org_profile,:allow_destroy => true
  accepts_nested_attributes_for :usage,:allow_destroy => true

  validates_presence_of :industry_ids

    perform_search_on :profile=>[:name,:intro,:intro_title],
      :educations=>[:degree_type,:school,:program,:comment],
      :experiences=>[:company_name, :job_title, :description,:industry],
      :skills=>[:name_en,:name_ch]

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
          :small    => ['40x40#',   :jpg],
          :medium   => ['150x250',    :jpg],
          :large    => ['500x500>',   :jpg]
        }
    else
      has_mongoid_attached_file :avatar,
        :default_url => 'avatars/:style/missing.png',

        :styles => {
          :original => ['1920x1680>', :jpg],
          :small    => ['40x40#',   :jpg],
          :medium   => ['150x250',    :jpg],
          :large    => ['500x500>',   :jpg]
        }
    end

    if Rails.env.production?  
      has_mongoid_attached_file :chinese_resume,
        :path => ':chinese_resume/:id/:filename',
        :storage => :s3,
        :bucket => 'talent-search',
        :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']}

    else
      has_mongoid_attached_file :chinese_resume

    end

    if Rails.env.production?
      has_mongoid_attached_file :english_resume,
        :path => ':english_resume/:id/:filename',
        :storage => :s3,
        :bucket => 'talent-search',
        :s3_credentials => {:access_key_id => ENV['S3_KEY'],:secret_access_key => ENV['S3_SECRET']}
    else
      has_mongoid_attached_file :english_resume
    end

  def steps
    %w{profile education exam language experience skill}
  end

  def next_step step
    steps[steps.index(step)+1]
  end

  def prev_step step
    steps[steps.index(step)-1]
  end

  def self.gen
    x=IndUser.create({email: Faker::Internet.email,password: 'password'})
    x.confirmed_at=Time.now
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

  def matching_companies
    OrgUser.all
  end

  def post_process params
    self.update_attributes(chinese_resume: nil) if params[:_destroy_chinese_resume]
    self.update_attributes(english_resume: nil) if params[:_destroy_english_resume]
  end

  def get_job_application job_post
    job_applications.where(:job_post_id=>job_post.id).first
  end

  def job_applied? job_post 
    job_applications.where(:job_post_id=>job_post.id)!=[]
  end

end
