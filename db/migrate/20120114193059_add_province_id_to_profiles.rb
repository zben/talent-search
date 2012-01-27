class AddProvinceIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :province_id, :integer
  end
end
