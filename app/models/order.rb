class Order < ActiveRecord::Base
  belongs_to :project
  has_many :order_items
  attr_accessible :notes, :ordered_at, :paid_for_by, :reimbursed, :shipping_cost, :status, :tax_cost, :vendor_name, :project, :project_id, :order_items_attributes
  accepts_nested_attributes_for :order_items, allow_destroy: true
  
  # The list of possible order statuses. Key: string stored in database, value: what is displayed to the user.
   STATUS_MAP = {
     "open" => "Open",
     "ordered" => "Ordered",
     "received" => "Received"
   }

   def subtotal
     order_items.map(&:total_cost).inject(0) { |sum, cost| sum + cost }
   end

   def total_cost
     subtotal + tax_cost.to_f + shipping_cost.to_f
   end
end
