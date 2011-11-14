class Article
  include Mongoid::Document
  
  field :title
  field :content
  field :date, :type => Date, :default => Date.today

  belongs_to :institution  
  belongs_to :person
  embeds_many :comments
  belongs_to :category
  validates_presence_of :date
  
  def add_comment(params)
    comments << Comment.new(params[:comment])
  end
  
  def find_comment(comment_id)
    comments.select {|comment| comment.id.to_s == comment_id}.first
  end
  
  def self.by_church_and_category(church, category)
    church.articles.select {|a| a.categories.include?(category)}
  end
  
  def display_categories
    categories.map {|cat| cat.name}.join(', ')
  end
  
end