class CompanySearch
  include Mongoid::Document
  include Mongoid::Timestamps
  include ApplicationHelper

  field :province_id, type: Integer
  field :people_count, type: Integer
  field :industry_id, type: Integer
  field :keywords, type: String

  def matching_companies
      users= OrgUser.with_org_profile
      users= users.where("org_profile.people_count_cd"=>people_count) if people_count
      users= users.where("org_profile.industry_id"=>industry_id) if industry_id
      users= users.where("org_profile.province_id"=>province_id) if province_id
      users= users.any_of(
        {"org_profile.company_name"=> /#{keywords}/},
        {"org_profile.short_description"=> /#{keywords}/},
        {"org_profile.long_description"=> /#{keywords}/}
      ) if keywords
      users
  end
end
