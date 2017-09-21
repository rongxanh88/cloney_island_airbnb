class AddCancellationToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :cancellation_policy, :integer, default: 0
  end
end
