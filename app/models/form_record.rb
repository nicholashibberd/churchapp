class FormRecord
  include Mongoid::Document
  
  belongs_to :form
  
  def user_defined_attributes
    attributes.except('_id', 'form_id')
  end
end