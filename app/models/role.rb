class Role
  include Mongoid::Document
  
  field :title
  belongs_to :user
end