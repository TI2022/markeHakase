class AddGoogleMapToStores < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :google_map, :string
    add_column :stores, :flagship_location, :boolean, default: false
  end
end
