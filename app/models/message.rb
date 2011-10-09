class Message
  include Mongoid::Document
  field :name, :type => String
  field :email, :type => String
  field :phone, :type => String
  field :message, :type => String
  
  belongs_to :church
end
