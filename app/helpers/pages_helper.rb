module PagesHelper
  def background_image(page)
    if !page.background_images.empty?
      content_tag(:div, (image_tag page.background_images.first.image.url(:original)), :id => "background_image")
    else
      return
    end
  end
  
  def content_layout
    if @page and !@page.background_images.empty?
      "background_image_layout"
    else
      "full_page_layout"
    end
  end
  
end
