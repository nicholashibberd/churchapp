class Photo 
  include Mongoid::Document
  include Mongoid::Paperclip
    
  field :caption
  field :position, :type => Integer
  
  belongs_to :church
  has_and_belongs_to_many :gallery_widgets
  
  has_mongoid_attached_file :photo, {
      :styles => {
        :thumb => "210x140",
        :stacked => "370"
         }
    }
       
       # # = exact aspect ratio
       # > = makes the largest size the size you specify
end
