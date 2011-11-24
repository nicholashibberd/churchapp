class Document
  include Mongoid::Document
  include Mongoid::Paperclip  

  field :document
  field :title
  
  belongs_to :institution
  
  has_mongoid_attached_file :pdf
  
end