class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :part_number, :null => false
      t.references :project, :null => false
      t.string :part_type, :null => false
      t.string :name, :null => false
      t.references :part
      t.text :notes
      t.string :status, :null => false
      t.string :source_material, :null => false
      t.boolean :have_material, :null => false
      t.integer :quantity, :null => false
      t.string :cut_length, :null => false
      t.integer :priority, :null => false
      t.integer :drawing_created, :null => false

      t.timestamps
    end
    add_index :parts, :project_id
    add_index :parts, :part_id
    
    add_index :parts, [:project_id, :part_number], unique: true
  end
end
