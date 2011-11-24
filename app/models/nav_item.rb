class NavItem
  include Mongoid::Document
  field :name
  field :target
  field :position
  field :link_type
  
  belongs_to :page 
  belongs_to :nav_menu
  
  before_create :set_position
  
  def set_position
    self.position = nav_menu.max_position + 1
  end
  
end
