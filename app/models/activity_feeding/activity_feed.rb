# encoding: UTF-8
class ActivityFeed
  include Mongoid::Document
  include Mongoid::Timestamps

  
  field :text
  field :link
  field :verb
#  include SimpleEnum::Mongoid
#  as_enum :verb,    :"创建了"=>10,
#                    :"更新了"=>20,
#                    :"发布了"=>30,
#                    :"添加评论"=>40,
#                    :"加入了"=>50
  
  belongs_to :user
   
  def self.feed_for(user,*types)
    where(:user_id.in=> user.bookmarked_ids(*types))
  end
  
end
