class Widget
  include Mongoid::Document
  field :position, :type => Integer
  field :css_id
  #field :column, :default => 'left'
  field :width, :type => Integer, :default => 880
  field :height, :type => Integer, :default => 150
  field :top, :type => Integer, :default => 0
  field :left, :type => Integer, :default => 0
  belongs_to :page
  
  referenced_in :page, :inverse_of => :widgets
  
  before_create :set_css_id, :set_position, :set_height
  
  def widget_type
    self._type.underscore
  end
  
  def set_css_id
    widget_number = page.max_widget_number + 1
    self.css_id = "#{widget_type}_#{widget_number}"
  end
  
  def set_position
    self.position = page.max_position + 1
  end
  
  def set_height
    if page.content_layout == 'fluid'
      self.top = page.widget_area_height - 30
      new_widget_area_height = page.widget_area_height + 170
      page.update_attributes(:widget_area_height => new_widget_area_height)
    end
  end
  
end
