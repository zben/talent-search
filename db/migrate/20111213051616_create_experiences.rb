class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.integer :user_id
      t.string :company_name
      t.string :company_location
      t.string :job_title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
  end
end
