class GalleryWidget < Widget
  has_and_belongs_to_many :photos
  
  field :display, :default => 'Stacked'
  
end