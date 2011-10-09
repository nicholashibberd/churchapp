class ContactFormWidget < Widget
  include Mongoid::Document
  
  field :name
end