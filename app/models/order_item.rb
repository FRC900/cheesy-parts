class OrderItem < ActiveRecord::Base
  belongs_to :project
  belongs_to :order
  attr_accessible :description, :notes, :part_number, :quantity, :unit_cost
end
