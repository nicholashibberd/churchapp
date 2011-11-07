class Site
  include Mongoid::Document
  field :domain
  field :site_type
  
  has_many :institutions
  
  def find_institution(institution_id)
    church = institutions.where(:slug => institution_id).first
    church ||= institutions.select {|institution| institution.is_a?(Parish)}.first
    church
  end
  
end