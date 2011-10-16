class Page
  include Mongoid::Document
  field :name, :type => String
  field :slug, :type => String
  field :title, :type => String
  
  belongs_to :church
  belongs_to :parish
  has_many :widgets
  has_one :nav_item  
  
  #embeds_one :map_widget
  references_many :widgets, :order => :position
  
  
  validates_uniqueness_of :name, :scope => :church_id
  
  before_create :generate_slug
  
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

  def order_dishes
    dishes.each do |dish|
      dish.position = params['dish'].index(dish.id.to_s) + 1
      dish.save
    end
    render :nothing => true
  end
  
  def max_widget_number
    widgets_with_ids = widgets.select {|widget| !widget.css_id.nil?}
    widget_numbers = widgets_with_ids.map {|widget| widget.css_id.gsub("#{widget.widget_type}_", "")}
    widget_numbers.max.to_i
  end
  
  def widgets_by_column(side)
    widgets.where(:column => side).asc(:position)
  end
  
end
