class ArticlesWidget < Widget
  field :number_to_display, :type => Integer, :default => 5
  field :snippet_size, :type => Integer, :default => 300
  belongs_to :category
end