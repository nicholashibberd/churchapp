class BackgroundImage
  include Mongoid::Document
  include Mongoid::Paperclip
  
  field :name
  
  belongs_to :institution
  has_and_belongs_to_many :pages
  
  has_mongoid_attached_file :image, {
      :styles => {
        :original => "1160",
        :preview => "200"
         }
    }
end
