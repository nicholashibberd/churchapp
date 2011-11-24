class Page
  include Mongoid::Document
  include Mongoid::Paperclip
  
  field :name, :type => String
  field :slug, :type => String
  field :title, :type => String
  field :widget_area_height, :type => Integer
  field :content_layout, :default => 'fixed'
  
  belongs_to :institution
  has_many :widgets
  has_one :nav_item  
  has_and_belongs_to_many :background_images
  
  references_many :widgets, :order => :position
    
  validates_uniqueness_of :name, :scope => :institution_id
  
  before_create :generate_slug
  before_save :set_fluid_layout  
  before_save :set_widget_area_height
    
  def generate_slug
    self.slug = name.gsub("'", "").parameterize
  end
  
  def to_param
    slug
  end
  
  def find_widget(widget_id)
    widgets.select {|widget| widget.id.to_s == widget_id}.first
  end
  
  def add_widget(params)
    widget_type = params[:widget_type]
    widget_class = widget_type.classify.constantize
    widgets << widget_class.new(params[widget_type])
  end
  
  def update_widget(params)
    widget_type = params[:widget_type]
    @widget = find_widget(params[:id])
    @widget.update_attributes(params[widget_type])
  end
  
  def order_widgets(params)
    widget_ids = params[:widget]
    widget_ids.each_with_index do |widget_id, index|
      Widget.find(widget_id).update_attributes(:position => index + 1, :column => params[:column])
    end
  end

  def max_widget_number
    widgets_with_ids = widgets.select {|widget| !widget.css_id.nil?}
    widget_numbers = widgets_with_ids.map {|widget| widget.css_id.gsub("#{widget.widget_type}_", "")}
    widget_numbers.max.to_i
  end
  
  def widgets_by_column(side)
    widgets.where(:column => side).asc(:position)
  end
  
  def max_position
    existing_widgets = widgets.select {|widget| !widget.position.nil?}
    current_highest = existing_widgets.map(&:position).max
    current_highest ||= 0
  end
  
  def set_widget_area_height
    unless content_layout == 'fixed'
      #raise widgets.map {|widget| widget.top.to_i + widget.height.to_i}.inspect
      max_height = widgets.map {|widget| widget.top.to_i + widget.height.to_i}.max
      self.widget_area_height = max_height + 50
    end
  end
  
  def set_fluid_layout
    return unless self.content_layout_changed? && self.content_layout == 'fluid'
    widgets.each_with_index do |widget, index|
      top = index * 190
      widget.update_attributes(:width => 880, :height => 150, :top => top, :left => 0)
    end
    
  end
  
end
