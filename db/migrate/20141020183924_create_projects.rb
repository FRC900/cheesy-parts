class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, :null => false, :unique => true
      t.string :part_number_prefix, :null => false, :unique => true
      t.boolean :hide_dashboards, :null => false

      t.timestamps
    end
  end
end
