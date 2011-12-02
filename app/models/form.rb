class Form
  include Mongoid::Document
  
  has_many :form_widgets
  has_many :form_records
  belongs_to :institution
  
  field :name
  
  embeds_many :form_fields
  accepts_nested_attributes_for :form_fields, :allow_destroy => true  
  
  before_save :generate_field_slugs
  
  def generate_field_slugs
    form_fields.each { |ff| ff.generate_slug }
  end
  
end
