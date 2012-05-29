#encoding: UTF-8
module ApplicationHelper

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
  
    def get_csv_data path
      require 'csv'
      csv_data = CSV.read path,:encoding=>'utf-8'
      headers = csv_data.shift.map {|i| i.to_s }
      string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
      array_of_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }

    end
  end  
  
  def update_skills(item, params)
    
    item.skills=[]
    item.skills << Skill.find(params[:jobpost][:skill_ids]) if params[:jobpost]
    params[:skills].split(",").each do |skill_name|
        if !skill_name.strip.empty? && skill_name!="在此输入技能"
          item.skills << Skill.send("find_or_create_by", :"name_#{I18n.locale}"=>skill_name)
        end
    end
    params[:as_values_skills].split(",").each do |skill_id|
      if skill_id.to_f!=0
        skill = Skill.find(skill_id)
        item.skills << skill unless item.skills.include?(skill) 
      elsif !skill_id.strip.empty?
        new_skill = Skill.send("find_or_create_by", :"name_#{I18n.locale}"=>skill_id)
        item.skills << new_skill
      end   
    end
    
  end
  
  def remove_avatar user
    user.avatar=nil if user.is_a? IndUser
     
    user.logo=nil if user.is_a? OrgUser
     
    user.save
  end
  
  def yearmonth date
    date.blank? ? nil : l(date,:format=>:long2)
  end
  
  def bookmark_code bookmarkable
    result = bookmarkable.bookmarkings.where(:user_id=>current_user.id)
    if result.count==0
      link_to "关注",toggle_bookmark_path(bookmarkable.class.name,bookmarkable.id.to_s),
        :class=>"btn spinner bookmark primary #{bookmarkable.id}",:remote=>true
    else
      link_to "取消关注",toggle_bookmark_path(bookmarkable.class.name,bookmarkable.id.to_s),
        :class=>"btn bookmark primary #{bookmarkable.id}",:remote=>true
    end
  end
  
  def view_code bookmarkable
    link_to "查看",bookmarkable,:class=>"btn"
  end
  
  def highlight_link text 
    regex = Regexp.new '(https?:\/\/|www\.)(([-\w\.]+)+(:\d+)?(\/([\w\/_\-\.]*(\?\S+)?)?)?)'
    text.gsub!( regex, '<a target="blank" href="http://\2">[链接:\3]</a>' )
    text
  end

  def is_active? controller_and_action
    controller, action = controller_and_action.split("#")
    (params[:controller]=~/#{controller}/ && params[:action]=~/#{action}/) ? 'active':''
  end

  def controller_action
    params["controller"].gsub("/","-") + " " + params["action"]
  end
end



