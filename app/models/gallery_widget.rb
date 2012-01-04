class GalleryWidget < Widget
  has_and_belongs_to_many :photos
  
  field :display, :default => 'Stacked'
  field :display_caption, :default => false, :type => Boolean
  field :display_in_lightbox, :default => true, :type => Boolean
  
end