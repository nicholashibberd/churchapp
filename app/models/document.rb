class Document
  include Mongoid::Document

  field :document
  field :title
  
  belongs_to :institution
end