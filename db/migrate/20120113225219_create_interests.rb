class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name_en
      t.string :name_ch

      t.timestamps
    end
  end
end
