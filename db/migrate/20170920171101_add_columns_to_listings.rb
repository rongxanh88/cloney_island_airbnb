class AddColumnsToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :name, :string
    add_column :listings, :description, :text
    add_column :listings, :accomodates, :integer
    add_column :listings, :bathrooms, :integer
    add_column :listings, :bedrooms, :integer
    add_column :listings, :beds, :integer
    add_column :listings, :price, :float
    add_column :listings, :house_rules, :text
    add_column :listings, :property_type, :integer
    add_column :listings, :bed_type, :integer
    add_column :listings, :pet_type, :integer
    add_column :listings, :room_type, :integer
    add_column :listings, :status, :integer
    add_column :listings, :address, :text
  end
end
