# encoding: UTF-8
class JobApplication 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper
 
  belongs_to :ind_user
  belongs_to :job_post
  



end
