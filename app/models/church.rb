class Church < Institution
  belongs_to :parish
  
  validates_uniqueness_of :name, :scope => :parish_id
  
  field :name
  field :slug
  field :church_type
  
  after_create :create_main_nav
    
  def articles_by_month(category_id, month)
    articles.where()
  end
  
  def articles_by_category(category_id)
    articles.where(:category_id => category_id)
  end
  
  def find_events_by_month(month)
    events.select {|event| event.start_date.month == month}
  end  
  
  def create_main_nav
    nav_menus.create(:name => 'Main Navigation', :menu_type => 'main_navigation')
  end
  
end
