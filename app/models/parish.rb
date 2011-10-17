class Parish < Institution
  field :name
  field :slug
    
  def find_church(slug)
    Church.first(:conditions => {:parish_id => self.id, :slug => slug})
  end
  
  def find_category(slug)
    Category.first(:conditions => {:parish_id => self.id, :slug => slug})
  end
  
  def church_events
    churches.map {|church| church.events}.flatten
  end
  
  def find_events_by_month(month)  
    total_events = church_events + events
    total_events.select {|event| event.start_date.month == month}
  end  
  
end