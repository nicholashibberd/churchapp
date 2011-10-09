class Comment
  include Mongoid::Document
  field :message, :type => String
  field :name, :type => String
  
  embedded_in :articles, :inverse_of => :comments
end