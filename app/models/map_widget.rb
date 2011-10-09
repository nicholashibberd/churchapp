class MapWidget < Widget
  
  field :address
  field :zoom, :type => Integer
  accepts_nested_attributes_for :map_markers, :allow_destroy => true
  embeds_many :map_markers
  
  def map_json
    { 
			:markers =>  [
				{ :latitude => 47.651968,
		      :longitude => 9.478485,
		      :html => "_latlng" 
				},
		    { :address => "SW17 6AW",
		      :html => "Tooting" 
				},
	     	{ :address => "EC1R 3AU",
		      :html => "Farringdon" 
				}],
		  :address => "London, England",
		  :zoom => 10
		}.to_json
  end
  
  def map_to_json
    {
      :address => address,
      :zoom => zoom,
      :markers => map_markers.map {|marker| {:address => marker.address, :html => marker.html}}
    }.to_json
  end
end