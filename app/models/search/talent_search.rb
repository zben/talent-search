class TalentSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper


  field :min_age, type: Integer
  field :max_age, type: Integer
  field :keywords
  field :skills
  
  def matching_talent

      users = IndUser.with_ind_profile
      users = users.where("profile.birthday"=>{'$lte'=>Time.now - min_age.to_i.years}) unless min_age.nil?
      users = users.where("profile.birthday"=>{'$gte'=>Time.now - max_age.to_i.years})  unless max_age.nil?
      users = users.any_of({"profile.name"=> /#{keywords}/}) if keywords
      users
  end
end
