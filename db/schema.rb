# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141020185351) do

  create_table "order_items", :force => true do |t|
    t.integer  "project_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.string   "part_number"
    t.string   "description"
    t.decimal  "unit_cost"
    t.text     "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["project_id"], :name => "index_order_items_on_project_id"

  create_table "orders", :force => true do |t|
    t.integer  "project_id",    :null => false
    t.string   "vendor_name"
    t.string   "status",        :null => false
    t.datetime "ordered_at"
    t.string   "paid_for_by"
    t.decimal  "tax_cost"
    t.decimal  "shipping_cost"
    t.text     "notes"
    t.boolean  "reimbursed",    :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "orders", ["project_id"], :name => "index_orders_on_project_id"

  create_table "parts", :force => true do |t|
    t.integer  "part_number",     :null => false
    t.integer  "project_id",      :null => false
    t.string   "part_type",       :null => false
    t.string   "name",            :null => false
    t.integer  "part_id"
    t.text     "notes"
    t.string   "status",          :null => false
    t.string   "source_material", :null => false
    t.boolean  "have_material",   :null => false
    t.integer  "quantity",        :null => false
    t.string   "cut_length",      :null => false
    t.integer  "priority",        :null => false
    t.integer  "drawing_created", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "parts", ["part_id"], :name => "index_parts_on_part_id"
  add_index "parts", ["project_id", "part_number"], :name => "index_parts_on_project_id_and_part_number", :unique => true
  add_index "parts", ["project_id"], :name => "index_parts_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name",               :null => false
    t.string   "part_number_prefix", :null => false
    t.boolean  "hide_dashboards",    :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "permission",    :default => "readonly", :null => false
    t.string   "first_name",                            :null => false
    t.string   "last_name",                             :null => false
    t.boolean  "enabled",       :default => false,      :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

end
