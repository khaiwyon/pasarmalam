class AddPriceToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :price, :decimal
  end
end
