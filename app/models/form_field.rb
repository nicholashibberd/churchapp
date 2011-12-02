class FormField
  include Mongoid::Document
  
  field :name
  field :slug
  field :field_type
  field :values
  
  embedded_in :form, :inverse_of => :form_fields
        
  def generate_slug
    self.slug = name.gsub("'", "").parameterize('_')
  end
  
  def values_to_array
    values.split(',').each {|v| v.strip!}
  end
  
end