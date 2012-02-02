class OrgProfile
  include Mongoid::Document
  include Mongoid::Timestamps

    
  field :company_name
  field :short_description
  field :long_description
  field :people_count, type: Integer
  field :contact_person
  field :phone_number
  field :email
  field :website


  belongs_to :city
  belongs_to :industry
  embedded_in :user
  field :city_id, type: Integer
  field :industry_id, type: Integer
end
