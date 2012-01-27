ActiveRecord::Base.transaction do
  SkillCategory.all.each{|x| x.destroy}
  Skill.all.each{|x| x.destroy}
end

ActiveRecord::Base.transaction do  
  Dir['db/skills/*'].each do |file|
    category_name = file.split("/").last
    skill_file = File.new(file)
    cat = SkillCategory.create(:name_en=>category_name)
    while (line=skill_file.gets)
      unless line.strip.blank?
        cat.skills.build(:name_en=>line.strip).save
      end
    end
  end
end
