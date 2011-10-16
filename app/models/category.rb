class Category
  include Mongoid::Document
  field :name, :type => String
  field :slug
  
  before_create :generate_slug
  has_and_belongs_to_many  :articles
  
  validates_uniqueness_of :name
  
  def to_param
    slug
  end
  
  def self.find_by_slug(slug)
    self.where(:slug => slug).first
  end
  
  def generate_slug
    self.slug = name.gsub("'", "").parameterize
  end
  
  def find_articles_by_church(church, month)
    if month
      articles.desc(:date).select {|a| a.church_id == church.id && a.date.strftime('%m-%Y') == month}
    else
      articles.where(:church_id => church.id).desc(:date)
    end
  end
end
