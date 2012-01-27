class FixColumnNamesToProfiles < ActiveRecord::Migration
  def self.up
    rename_column :profiles, :gender, :gender_id
    
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end

end
