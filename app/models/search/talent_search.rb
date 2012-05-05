class TalentSearch 
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper


  belongs_to :province
  field :keywords


  def matching_talent

      users = IndUser.with_ind_profile
      users = users.where("profile.province_id"=>province_id.to_i) unless province_id.nil?
      users = users.any_of({"full_text"=> /#{keywords}/}) if keywords
  end
end
