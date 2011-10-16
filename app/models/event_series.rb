class EventSeries
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  has_many :events, :dependent => :destroy
  belongs_to :church  
  
  field :title
  field :start_time, :type => DateTime
  field :end_time, :type => DateTime
  field :summary
  field :content
  field :description
  field :all_day
  field :period
  field :frequency
  field :series_id
  field :category  
  field :event_series_id  
  
  validates_presence_of :frequency
  validates_presence_of :period
  validates_presence_of :start_time
  validates_presence_of :end_time
  
  after_create :create_events
      
  def new_datetime(date)
    DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, start_time.sec)
  end
  
  def create_events
    st = start_time
    et = end_time
    p = recurrence_period(period)
    nst, net = st, et
    while frequency.to_i.send(p).from_now(st) <= end_time
      self.events.create(:title => title, :description => description, :all_day => all_day, :start_time => nst, :end_time => net, :category => category, :church_id => church_id)
      nst = st = frequency.to_i.send(p).from_now(st)
      net = et = frequency.to_i.send(p).from_now(et)
      if period.downcase == 'monthly' or period.downcase == 'yearly'
        begin 
          nst = DateTime.parse("#{starttime.hour}:#{starttime.min}:#{starttime.sec}, #{starttime.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{endtime.hour}:#{endtime.min}:#{endtime.sec}, #{endtime.day}-#{et.month}-#{et.year}")
        rescue
          nst = net = nil
        end
      end
    end
  end

  def recurrence_period(period)
    case period
      when 'Daily'
      period = 'days'
      when "Weekly"
      period = 'weeks'
      when "Monthly"
      period = 'months'
      when "Yearly"
      period = 'years'
    end
    return period
  end
  
  
  
end