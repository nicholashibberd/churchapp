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
        :thumb => "210x140",
        :stacked => "370"
         }
    }
       
       # # = exact aspect ratio
       # > = makes the largest size the size you specify
       
   def set_position
     self.position = institution.max_photo_position + 1
   end
end
