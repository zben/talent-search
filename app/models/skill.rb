class Skill
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name_ch
  field :name_en
  
  belongs_to :skill_category
  has_and_belongs_to_many :users
  has_and_belongs_to_many :job_posts
  
  def to_json
    super(:only=>[:id,:name_en])
  end
  
  def self.populate
       data=File.new("db/base_data/skills_file.txt").lines
       current_category = nil
       SkillCategory.delete_all
       Skill.delete_all

         data.each do |line|
          if !line.strip.empty?
            if line.start_with?(" ")==false
              result = line.strip.split("//")
              current_category = SkillCategory.create(:name_en=>result[0],:name_ch=>result[1])
            else
              result = line.strip.split("//")
              current_category.skills.create(:name_en=>result[0],:name_ch=>result[1])
            end
          end
        end
       
  end
end
