class Part < ActiveRecord::Base
  before_save :set_defaults
  belongs_to :project
  belongs_to :part
  has_many :parts
  
  attr_accessible :cut_length, :drawing_created, :have_material, :name, :notes, :part_number, :part_type, :priority, :quantity, :source_material, :status, :part_id, :project_id

  PART_TYPES = ["part", "assembly"]

  # The list of possible part statuses. Key: string stored in database, value: what is displayed to the user.
  STATUS_MAP = { "designing" => "Design in progress",
                 "material" => "Material needs to be ordered",
                 "ordered" => "Waiting for materials",
                 "drawing" => "Needs drawing",
                 "ready" => "Ready to manufacture",
                 "manufacturing" => "Manufacturing in progress",
                 "outsourced" => "Waiting for outsourced manufacturing",
                 "welding" => "Waiting for welding",
                 "scotchbrite" => "Waiting for Scotch-Brite",
                 "anodize" => "Ready for anodize",
                 "powder" => "Ready for powder coating",
                 "coating" => "Waiting for coating",
                 "assembly" => "Waiting for assembly",
                 "done" => "Done" }

  # Mapping of priority integer stored in database to what is displayed to the user.
  PRIORITY_MAP = { 0 => "High", 1 => "Normal", 2 => "Low" }
  
  def set_defaults
    self.part_number ||= Part.generate_number_and_create(self.project, self.part_type, self.part)
    self.status ||= "designing"
    self.source_material ||= ""
    self.have_material ||= 0
    self.quantity ||= 0
    self.cut_length ||= ""
    self.priority ||= 1
    self.drawing_created ||= 0
  end
  
  # Assigns a part number based on the parent and type and returns a new Part object.
  def self.generate_number_and_create(project, type, parent_part)
    parent_part_id = parent_part.nil? ? 0 : parent_part.id
    parent_part_number = parent_part.nil? ? 0 : parent_part.part_number
    if type.downcase == "part"
      part_number = Part.where("project_id = ? and part_id = ? and lower(part_type) = ?", project.id, parent_part_id, "part").maximum(:part_number) || parent_part_number
      part_number += 1
    else
      part_number = Part.where("project_id = ? and lower(part_type) = ?",project.id,"assembly").maximum(:part_number)  || 0
      part_number += 100
    end
  end

  def full_part_number
    "#{project.part_number_prefix}-#{part_type == "assembly" ? "A" : "P"}-%04d" % part_number
  end
  def display_name
     "#{self.full_part_number} - #{self.name}"
  end
end
