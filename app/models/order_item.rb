class OrderItem < ActiveRecord::Base
  belongs_to :project
  belongs_to :order
  attr_accessible :description, :notes, :part_number, :quantity, :unit_cost, :project_id, :order_id
  
  def total_cost
    unit_cost * quantity
  end
end
