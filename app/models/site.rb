class Site
  include Mongoid::Document
  field :domain
  field :site_type
  
  has_one :church
  has_one :parish
end