class OrganizationProfile < ActiveRecord::Base
  attr_accessible :name, :short_description, :long_description, :location_id, :contact_person, :phone_number, :email, :logo, :website
has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
