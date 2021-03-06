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
  
  def fluid_or_fixed_layout(page, action)
    partial = page.content_layout == 'fluid' ? "pages/#{action}/fluid_layout" : "pages/#{action}/fixed_layout"
      render partial, :page => page
      
  end
  
  def advent_calendar_days
    ['snowman', 'santa', 'reindeer', 'bird', 'fish', 'father_christmas', 'santa', 'bird', 'fish', 'snowman', 'father_christmas', 'reindeer', 'fish', 'father_christmas', 'bird', 'santa', 'reindeer', 'snowman', 'santa', 'reindeer', 'bird', 'fish', 'bird', 'father_christmas']
  end
  
end
