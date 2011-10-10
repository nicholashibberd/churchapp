class Church < Institution
  belongs_to :parish
  has_many :pages  
  has_many :articles
  has_many :events
  has_many :nav_menus
  has_many :photos
  has_many :messages
  
  validates_uniqueness_of :name, :scope => :parish_id
  
  field :name
  field :slug
    
  def events_by_date(category, number_to_display)
    upcoming_events = events.upcoming.where(:category => category).limit(number_to_display)
    upcoming_events.group_by {|event| event.start_date}
  end
  
  def articles_by_month(category_id, month)
    articles.where()
  end
  
  def articles_by_category(category_id)
    articles.where(:category_id => category_id)
  end
  
  def find_events_by_month(month)
    events.select {|event| event.start_date.month == month}
  end  
  
  def order_photos(params)
    photos.each do |photo|
      photo.position = params['photo'].index(photo.id.to_s) + 1
      photo.save!
    end
  end
  
end