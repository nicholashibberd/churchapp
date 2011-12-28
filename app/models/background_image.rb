class BackgroundImage
  include Mongoid::Document
  include Mongoid::Paperclip
  
  field :name
  
  belongs_to :institution
  has_and_belongs_to_many :pages
  
  has_mongoid_attached_file :image, {
    :styles => lambda { |attachment| { 
      #:original => (attachment.instance.institution.background_image_size),
      :original => (attachment.instance.styles),
      :preview => '200'    
      }
    }
  }
  
  def styles
    case institution.site.name
      when "Sanderstead Parish" then "1160"
      when "Jen and Andrew" then "830"
      else "250"
    end
  end
  
end
