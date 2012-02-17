class Category
  include Mongoid::Document
  field :name, :type => String
  field :slug
  
  before_create :generate_slug
  has_many :articles
  
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
  
  def find_articles_by_church(institution, month)
    if month
      articles.desc(:date).select {|a| a.institution_id == institution.id && a.date.strftime('%m-%Y') == month}
    else
      articles.where(:institution_id => institution.id).desc(:date)
    end
  end
  
  def find_limited_articles_by_church(institution, month, count)
    articles = find_articles_by_church(institution, month)
    month ? articles : articles.limit(Integer(count))
  end
end
