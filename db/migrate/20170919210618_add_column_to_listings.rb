class AddColumnToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :airbnb_id, :integer
  end
end
