class DocumentsController < ApplicationController
  layout 'admin', :except => :show
  def show
    
  end
  
  def new
    @document = Document.new
  end
  
  def edit
    
  end
  
  def index
    @photos = @church.photos.all
  end
  
  def create
    attachment_param = params[:document]
    new_filename = "test_doc.pdf"
    
    create_doc(attachment_param, new_filename)

    page = @site.find_page(slug)
    
    #Create new image unit
    if image_type == 'unit'
      page.add_unit('image', {:site => site, :filename => new_filename})
    
    #Create new background image
    elsif image_type == 'background'
      page.add_background_image(:site => site, :filename => new_filename)
    end
    
    redirect_to :controller => 'pages', :action => 'edit', :id => slug
  end

  def create_doc(attachment_param, new_filename)
    if attachment_param.nil?
      flash[:message] = "No doc selected to upload"
    else
      filename = File.basename(attachment_param.original_filename)
      resized_filename = Rails.root.join('public','pdf', "sanderstead", "#{new_filename}")
      target_directory = Rails.root.join('public','pdf', "sanderstead")
      
      if !File.directory?(target_directory)
        FileUtils.mkpath(target_directory)
      end

      original = MiniMagick::Image.read(attachment_param.read)

      img_width, img_height = original['%w %h'].split
      img_width = img_width.to_f
      img_height = img_height.to_f

      if img_width > MAX_WIDTH or img_height > MAX_HEIGHT
        # Need to resize
        if (img_width/img_height) > (MAX_WIDTH/MAX_HEIGHT)
          # Image is wider in proportion than the space
          percentage = (MAX_WIDTH * 100.0) / img_width
        else
          # Image is taller in proportion than the space
          percentage = (MAX_HEIGHT * 100.0) / img_height
        end
        original.resize "#{percentage}%"
      end
      original.write resized_filename
      File.new(resized_filename).chmod(0644) 
    end
  end
end