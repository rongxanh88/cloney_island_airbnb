class AddAddressToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :street_address, :string
    add_column :experiences, :city, :string
    add_column :experiences, :state, :string
    add_column :experiences, :zipcode, :string
  end
end
