class AddReceiptNameToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :receipt_name, :string
  end
end
