class Order < ActiveRecord::Base
  belongs_to :project
  attr_accessible :notes, :ordered_at, :paid_for_by, :reimbursed, :shipping_cost, :status, :tax_cost, :vendor_name
end
