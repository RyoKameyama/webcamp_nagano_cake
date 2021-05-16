class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :customer_id, :integer
    add_column :orders, :payment_method, :integer
    add_column :orders, :shipping_cost, :integer
    add_column :orders, :postal_code, :string
    add_column :orders, :address, :string
    add_column :orders, :name, :string
    add_column :orders, :billed_amount, :integer
    add_column :orders, :amount, :integer
    add_column :orders, :delivery_status, :integer
  end
end
