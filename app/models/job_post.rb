# encoding: UTF-8
class JobPost < ActiveRecord::Base
  include ApplicationHelper
  
  attr_accessible :title, :city_id, :industry_id, :years_required, 
      :company_name, :company_id, :description, 
      :job_requirement, :job_type_id, :salary, :expiration, :contact_person, :phone_number, :email, :logo, :website, :user_id, :skill_ids
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :industry
  belongs_to_active_hash :city
  belongs_to :company
  belongs_to_active_hash :job_type
  belongs_to :user
  has_and_belongs_to_many :skills
  
  
  def mcount user
    (skills.to_set & user.skills.to_set).size    
  end
  
  def matches
    users = skills.map{|skill| skill.users}.flatten.uniq
    users.sort!{|a,b| a.mcount(self) <=> b.mcount(self)}
  end
  
  def self.populate
    JobPost.delete_all
    data = get_csv_data 'db/job_posts.csv'
    transaction do
      data.each do |post|
        city = City.where('name_ch LIKE ?',"%#{post['city_id']}%") 
        city = City.where('name_ch LIKE ?',"%其他%") if city.empty?
        puts city[0].name
        puts post
        JobPost.create(post.merge({"city_id"=>city[0].id })
        )
      end
    end
    
  end
end
