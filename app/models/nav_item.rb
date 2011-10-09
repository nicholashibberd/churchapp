class NavItem
  include Mongoid::Document
  field :name
  field :target
  field :position
  
  belongs_to :page 
  belongs_to :nav_menu
  
end
