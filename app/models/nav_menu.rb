class NavMenu
  include Mongoid::Document
  field :name
  field :menu_type
  
  belongs_to :church
  belongs_to :parish 
  has_many :nav_items
  
  def order_nav_items(params)
    nav_items.each do |nav_item|
      nav_item.position = params['navitem'].index(nav_item.id.to_s) + 1
      nav_item.save!
    end
  end
  
end
