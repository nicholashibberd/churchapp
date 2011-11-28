class DocumentsController < ApplicationController
  layout 'admin', :except => :show
  def show
    
  end
  
  def new
    @document = Document.new
  end
  
  def edit
    @document = Document.find(params[:id])
  end
  
  def index
    @photos = @church.photos.all
  end
  
  def show
    @document = Document.find(params[:id])
    return send_file @document.pdf.path, :type => "application/pdf", :filename => "making_space.pdf", :disposition => 'inline'
  end
  
  def create
    @document = Document.new(params[:document])
    if @document.save
      redirect_to documents_path(@document.institution), :notice => "Successfully created document"
    else
      flash[:error] = "There was an error creating the document"
      render :action => 'new'
    end
  end
  
end