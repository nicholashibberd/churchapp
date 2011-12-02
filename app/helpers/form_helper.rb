module FormHelper
  def render_form_field_tag(field)
    case field.field_type
      when 'text_field' then text_field_tag "form_record[#{field.slug}]"
      when 'text_area' then text_area_tag "form_record[#{field.slug}]"
      when 'select' then select_tag "form_record[#{field.slug}]", options_for_select(field.values_to_array)
      when 'radio_buttons' then render 'forms/multiple_values', :field => field
      when 'check_boxes' then check_box_tag "form_record[#{field.slug}]"
    end
  end
  
  def radio_button_field(field)
    xml = Builder::XmlMarkup.new
    field.values_to_array.each do |value|
      xml.div :class => 'calendar_event_day' do
        radio_button_tag "form_record[#{field.slug}][][#{value}]", value
      end
    end
  end
  
end