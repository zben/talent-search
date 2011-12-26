class CreateEducations < ActiveRecord::Migration
  def self.up
    create_table :educations do |t|
      t.integer :user_id
      t.string :school
      t.string :school_location
      t.string :degree_type
      t.string :program
      t.date :start_date
      t.date :end_date
      t.float :GPA
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :educations
  end
end
