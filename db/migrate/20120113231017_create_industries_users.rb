class CreateIndustriesUsers < ActiveRecord::Migration
  def change
    create_table :industries_users do |t|
      t.integer :industry_id
      t.integer :user_id
      t.integer :interest_id

      t.timestamps
    end
  end
end
