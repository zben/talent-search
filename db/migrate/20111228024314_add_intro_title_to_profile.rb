class AddIntroTitleToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :intro_title, :string
  end
end
