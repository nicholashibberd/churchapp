class ArticlesWidget < Widget
  field :number_to_display
  field :snippet_size, :default => 300
  belongs_to :category
end