class ContentWidget < Widget
  include Mongoid::Document
  
  field :content
end