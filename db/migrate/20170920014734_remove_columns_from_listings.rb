class RemoveColumnsFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :name, :string
    remove_column :listings, :description, :string
    remove_column :listings, :accomodates, :string
    remove_column :listings, :bathrooms, :string
    remove_column :listings, :bedrooms, :string
    remove_column :listings, :beds, :string
    remove_column :listings, :price, :string
    remove_column :listings, :house_rules, :string
    remove_column :listings, :property_type, :string
    remove_column :listings, :bed_type, :string
    remove_column :listings, :pet_type, :string
    remove_column :listings, :room_type, :string
    remove_column :listings, :status, :string
    remove_column :listings, :cancellation_policy, :string
    remove_column :listings, :address, :string
    remove_column :listings, :latitude, :string
    remove_column :listings, :longitude, :string
  end
end
