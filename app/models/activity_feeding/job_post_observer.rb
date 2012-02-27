# encoding: UTF-8
class JobPostObserver < ActiveRecord::Observer
  include Rails.application.routes.url_helpers
 
  def after_create(job_post)
    ActivityFeed.create(:user_id=>job_post.user_id, :verb=>"发布了职位: ", :text=> job_post.title, :link=>job_post_path(job_post))
  end
  
  def after_update(job_post)
    ActivityFeed.create(:user_id=>job_post.user_id, :verb=>"更新了职位: ", :text=> job_post.title, :link=>job_post_path(job_post))
  end
  
end


