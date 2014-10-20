class Project < ActiveRecord::Base
  attr_accessible :hide_dashboards, :name, :part_number_prefix
end
