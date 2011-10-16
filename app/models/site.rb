class Site
  include Mongoid::Document
  field :domain
  field :site_type
  
  has_many :institutions
  
  def find_institution(church_id)
    church_id ? institutions.where(:slug => church_id).first : institutions.select {|institution| institution.is_a?(Parish)}.first
  end
  
end