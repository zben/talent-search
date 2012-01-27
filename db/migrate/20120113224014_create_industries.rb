class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :name_ch
      t.string :name_en

      t.timestamps
    end
  end
end
