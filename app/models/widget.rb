class Widget
  include Mongoid::Document
  field :position, :type => Integer
  field :css_id
  field :column, :default => 'left'
  belongs_to :page
  
  referenced_in :page, :inverse_of => :widgets
  
  before_create :set_css_id
  
  def widget_type
    self._type.underscore
  end
  
  def set_css_id
    widget_number = page.max_widget_number + 1
    self.css_id = "#{widget_type}_#{widget_number}"
  end
  
end
