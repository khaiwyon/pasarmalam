class AddBillplzToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :status, :integer
    add_column :orders, :paid_at, :datetime
    add_column :orders, :bill_id, :string
    add_column :orders, :bill_url, :string
  end
end
