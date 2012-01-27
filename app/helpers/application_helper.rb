module ApplicationHelper

  def get_csv_data path
    require 'csv'
    csv_data = CSV.read path,:encoding=>'utf-8'
    headers = csv_data.shift.map {|i| i.to_s }
    string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
    array_of_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }   
  end
  
  def update_skills(item, params)
    
    item.skills=[]
    params[:skills].split(",").each do |skill_name|
        unless skill_name.strip.empty?
          new_skill = Skill.send("find_or_create_by_name_#{I18n.locale}",skill_name) unless skill_name.empty?
          item.skills << new_skill
        end
    end
    params[:as_values_skills].split(",").each do |skill_id|
      if skill_id.to_f!=0
        skill = Skill.find(skill_id)
        item.skills << skill unless item.skills.include?(skill) 
      elsif !skill_id.strip.empty?
        new_skill = Skill.send("find_or_create_by_name_#{I18n.locale}",skill_id)
        item.skills << new_skill
      end   
    end
    
  end
  
  def remove_avatar user
    profile = user.profile
    profile.avatar=nil
    profile.save
  end
  
end


