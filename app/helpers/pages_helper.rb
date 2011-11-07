module PagesHelper
  def background_image(page)
    if !page.background_images.empty?
      image_tag page.background_images.first.image.url(:original)
    elsif !page.institution.background_images.empty?
      image_tag page.institution.background_images.first.image.url(:original)
    else
      return
    end
  end
end
