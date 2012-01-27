class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name_ch
      t.string :name_en
      t.integer :country_id

      t.timestamps
    end
  end
end
