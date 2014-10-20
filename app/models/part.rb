class Part < ActiveRecord::Base
  belongs_to :project
  belongs_to :part
  attr_accessible :cut_length, :drawing_created, :have_material, :name, :notes, :part_number, :part_type, :priority, :quantity, :source_material, :status
end
