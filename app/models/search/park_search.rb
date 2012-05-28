class ParkSearch
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  field :province_id, type: Integer
  field :keywords, type: String

  def matching_parks
      parks= Park.unscoped
      parks= parks.where("province_id"=>province_id) if province_id
      parks= parks.any_of(
        {"short_intro"=> /#{keywords}/},
        {"long_intro"=> /#{keywords}/}
      ) if keywords
      parks
  end
end

