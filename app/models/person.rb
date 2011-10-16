class Person
  include Mongoid::Document
  #include Mongoid::Paperclip
  
  field :name, :type => String
  field :role, :type => String
  field :profile, :type => String
  field :email, :type => String
  field :phone, :type => String
  field :image_uid
  
  image_accessor :image
  
  belongs_to :parish
  belongs_to :church
  
  #has_mongoid_attached_file :photo, {
      #:styles => {
        #:thumb => "150"
        #}
    #}
  
  has_many :articles
end
