class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.integer :user_id
      t.integer :language_option_id
      t.integer :language_level_id

      t.timestamps
    end
  end
end
