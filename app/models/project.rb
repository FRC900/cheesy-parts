class Project < ActiveRecord::Base
  attr_accessible :hide_dashboards, :name, :part_number_prefix
  
  has_many :parts
  has_many :orders
  
end
