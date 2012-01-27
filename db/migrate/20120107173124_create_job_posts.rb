class CreateJobPosts < ActiveRecord::Migration
  def self.up
    create_table :job_posts do |t|
      t.string :title
      t.integer :city_id
      t.integer :industry_id
      t.integer :years_required
      t.string :company_name
      t.integer :company_id
      t.text :description
      t.text :job_requirement
      t.integer :job_type_id
      t.integer :salary
      t.date :expiration
      t.string :contact_person
      t.string :phone_number
      t.string :email
      t.string :logo
      t.string :website
      t.timestamps
    end
  end

  def self.down
    drop_table :job_posts
  end
end
