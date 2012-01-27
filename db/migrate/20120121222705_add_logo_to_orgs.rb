class AddLogoToOrgs < ActiveRecord::Migration
 def self.up
    change_table :organization_profiles do |t|
      t.has_attached_file :logo
    end
  end

  def self.down
    drop_attached_file :organization_profiles, :logo
  end
end
