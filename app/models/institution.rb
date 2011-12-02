class Institution
  include Mongoid::Document  
  
  belongs_to :site
  has_many :photos
  has_many :background_images
  has_many :pages  
  has_many :articles
  has_many :events
  has_many :event_series
  has_many :nav_menus
  has_many :photos
  has_many :messages
  has_many :forms
  has_many :churches
  has_many :users
  has_many :documents
  has_many :people
  
  field :name
  field :slug
  field :institution_type
  
  before_create :generate_slug
  
  def to_param
    slug
  end
  
  def generate_slug
    self.slug = name.gsub("'", "").parameterize
  end
  
  def find_page(slug)
    pages.select {|page| page.slug == slug}.first
  end
  
  def main_nav
    nav_menus.where(:menu_type => 'main_navigation').first
  end
  
  def main_navigation_items
    main_nav.nav_items.asc(:position) rescue []
  end
  
  def find_events
    self.is_a?(Church) ? Event.church(self) : Event.parish(self)
  end
  
  def max_photo_position
    existing_photos = photos.select {|photo| !photo.position.nil?}
    current_highest = existing_photos.map(&:position).max
    current_highest ||= 0
  end
  
  def order_photos(params)
    photos.each do |photo|
      photo.position = params['photo'].index(photo.id.to_s) + 1
      photo.save!
    end
  end
  
  def is_root?
    institution_type == 'root'
  end
      
end