class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name_ch
      t.string :name_en
      t.integer :province_id

      t.timestamps
    end
  end
end
