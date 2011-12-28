class FormRecordsController < ApplicationController
  layout 'admin'
  
  def index
    @form = Form.find(params[:form_id])
  end
  
  def create
    form_record = FormRecord.new(params[:form_record])
    institution = form_record.form.institution
    page = Page.find(params[:page_id])
    if form_record.save
      notice = 'Thank you for your response'
    else
      notice = 'There was an error sending this form_record'
    end
    redirect_to church_page_path(institution, page), :notice => notice
  end
  
  def destroy
    form_record = FormRecord.find(params[:id])
    form = form_record.form
    form_record.destroy
    redirect_to form_form_records_path(form)
  end
end