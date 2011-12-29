class Site
  include Mongoid::Document
  field :name
  field :domain
  field :theme
  field :site_type
  field :footer_content
  
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
  
  def is_standalone?
    site_type == 'standalone'
  end
  
end