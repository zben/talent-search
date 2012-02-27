# encoding: UTF-8
class UserObserver < ActiveRecord::Observer
  include Rails.application.routes.url_helpers
 
  def after_create(user)
    ActivityFeed.create(:user_id=>user.id, :verb=>"加入了本网站")
  end
  
  def after_update(user)
    if user.is_a? IndUser
      ActivityFeed.create(:user_id=>user.id, :verb=>"更新了个人信息")
    elsif user.is_a? OrgUser
      ActivityFeed.create(:user_id=>user.id, :verb=>"更新了机构/企业信息")
    end
  end
  
end


