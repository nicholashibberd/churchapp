class Institution
  include Mongoid::Document  
  
  field :name
  
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
  
  def main_navigation_items
    main_nav = nav_menus.where(:menu_type => 'main_navigation').first
    main_nav.nav_items.asc(:position) rescue []
  end
  
  def find_events
    self.is_a?(Church) ? Event.church(self) : Event.parish(self)
  end
      
end