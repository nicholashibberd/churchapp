class Comment
  include Mongoid::Document
  include Rakismet::Model
  field :content, :type => String
  field :author
  
  embedded_in :articles, :inverse_of => :comments
end