class Event 
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  belongs_to :event_series
  belongs_to :institution
  
  field :title
  field :location
  field :start_time, :type => DateTime
  field :end_time, :type => DateTime
  field :summary
  field :description  
  field :content
  field :all_day
  field :period
  field :frequency
  field :series_id
  field :category
  
  validates_presence_of :start_time
  
  scope :services, :where => {:category => 'Service'}
  scope :upcoming, where(:start_time.gte => Time.now)
  scope :church, lambda { |church| where(:church_id => church.id) }
  scope :parish, lambda { |parish| where(:parish_id => parish.id) }
  
  REPEATS = [
              "Does not repeat",
              "Daily"          ,
              "Weekly"         ,
              "Monthly"        ,
              "Yearly"         
  ]
  
  CATEGORIES = [
              "None",
              "Service",
              "Coffee Morning"
  ]
    
  def start_date
    start_time.to_date
  end
  
  def end_date
    end_time.to_date
  end
  
end
