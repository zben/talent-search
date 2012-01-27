class CreateUsages < ActiveRecord::Migration
  def change
    create_table :usages do |t|
      t.integer :user_id
      t.boolean :find_job
      t.boolean :find_project
      t.boolean :find_partner
      t.boolean :find_money

      t.timestamps
    end
  end
end
