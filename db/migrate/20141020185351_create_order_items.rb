class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :project
      t.references :order
      t.integer :quantity
      t.string :part_number
      t.string :description
      t.decimal :unit_cost, :size=>[10,2]
      t.text :notes

      t.timestamps
    end
    add_index :order_items, :project_id
    add_index :order_items, :order_id
  end
end
