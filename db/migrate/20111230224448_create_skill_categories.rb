class CreateSkillCategories < ActiveRecord::Migration
  def change
    create_table :skill_categories do |t|
      t.string :name_en
      t.string :name_ch

      t.timestamps
    end
  end
end
