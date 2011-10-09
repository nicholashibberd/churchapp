class MapMarker
  include Mongoid::Document
  field :address
  field :html
  
  embedded_in :map_widget, :inverse_of => :map_markers
end