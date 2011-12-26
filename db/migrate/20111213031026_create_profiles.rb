class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :firstname
      t.string :lastname
      t.date :birthday
      t.integer :gender
      t.integer :citizenship
      t.integer :residence_country
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
