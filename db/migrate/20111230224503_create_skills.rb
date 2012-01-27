class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :skill_category_id
      t.string :name_en
      t.string :name_ch

      t.timestamps
    end
  end
end
