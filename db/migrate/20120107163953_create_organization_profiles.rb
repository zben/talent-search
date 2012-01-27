class CreateOrganizationProfiles < ActiveRecord::Migration
  def self.up
    create_table :organization_profiles do |t|
      t.string :name
      t.text :short_description
      t.text :long_description
      t.integer :location_id
      t.string :contact_person
      t.string :phone_number
      t.string :email
      t.string :logo
      t.string :website
      t.timestamps
    end
  end

  def self.down
    drop_table :organization_profiles
  end
end
