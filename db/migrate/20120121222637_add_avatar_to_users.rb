class AddAvatarToUsers < ActiveRecord::Migration
 def self.up
    change_table :profiles do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :profiles, :avatar
  end
end
