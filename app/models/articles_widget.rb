class ArticlesWidget < Widget
  field :number_to_display
  field :snippet_size, :type => Integer, :default => 300
  belongs_to :category
end