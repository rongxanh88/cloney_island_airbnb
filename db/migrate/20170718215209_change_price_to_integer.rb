class ChangePriceToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :listings, :price, :integer
  end
end
