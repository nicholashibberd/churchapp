class Photo 
  include Mongoid::Document
  include Mongoid::Paperclip
    
  field :caption
  field :position, :type => Integer
  
  belongs_to :institution
  has_and_belongs_to_many :gallery_widgets
  
  before_create :set_position
  
  has_mongoid_attached_file :photo, {
      :styles => {
        :original => "900x600",
        :thumb => "210x140",
        :stacked => "370"
         }
    }
       
       # "900x600" means maximum width in each case
       # # = exact aspect ratio
       # > = makes the largest size the size you specify
       
   def set_position
     self.position = institution.max_photo_position + 1
   end
end
