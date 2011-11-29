class Site
  include Mongoid::Document
  field :domain
  field :theme
  field :site_type
  
  has_many :institutions
  has_many :users
  
  def find_institution(institution_id)
    church = institutions.where(:slug => institution_id).first
    church ||= root
    church
  end
  
  def root
    institutions.select {|institution| institution.institution_type == 'root'}.first
  end
  
end