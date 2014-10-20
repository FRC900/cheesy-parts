class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :project, :null => false
      t.string :vendor_name
      t.string :status, :null => false
      t.datetime :ordered_at
      t.string :paid_for_by
      t.decimal :tax_cost, :size=>[10,2]
      t.decimal :shipping_cost, :size=>[10,2]
      t.text :notes
      t.boolean :reimbursed, :null => false

      t.timestamps
    end
    add_index :orders, :project_id
  end
end
