class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false, :unique => true
      t.string :password_hash
      t.string :password_salt
      t.string :permission, :null => false, :default=>"readonly"
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.boolean :enabled, :null => false, :default=>false

      t.timestamps
    end
  end
end
