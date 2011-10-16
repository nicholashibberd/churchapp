Factory.define :user do |user|
  user.name                   "Nick"
  user.email                  "nicholashibberd@hotmail.com"
  user.password               "password"
  user.password_confirmation  "password"
end

Factory.define :site do |site|
  site.domain                 "www.example.com"
  site.site_type                   "parish"
end

Factory.define :church do |church|
  church.name                 "All Saints"
end

Factory.define :parish do |parish|
  parish.name                 "Sanderstead"
end

Factory.define :page do |page|
  page.name                   "Test page"
end

Factory.define :article do |article|
  article.title               "Test article"
end

Factory.define :comment do |comment|
  comment.name                "Nick"
  comment.message             "This is a test comment"
end

Factory.define :category do |category|
  category.name               "Test category"
end

Factory.define :event do |event|
  event.title               "Test event"
  event.start_time          DateTime.now
  event.period              "Does not repeat"
end

Factory.define :event_series do |event_series|
  event_series.title        "Test event series"
  event_series.start_time   DateTime.now
  event_series.end_time     DateTime.now + 2.weeks
  event_series.period       "Weekly"
  event_series.frequency    1
end

Factory.define :message do |message|
  message.message           "This is a test message"
  message.phone             "0123012301230"
  message.email             "test@test.com"
end

Factory.define :nav_menu do |nav_menu|
  nav_menu.name           "Test nav menu"
end

Factory.define :nav_item do |nav_item|
  nav_item.name           "Test nav item"
end

Factory.define :map_widget do |map_widget|
  map_widget.address      "48 Brian Avenue, Sanderstead Surrey, CR2 9NE"
end

Factory.define :content_widget do |content_widget|
  content_widget.content  "This is test content"
end

Factory.define :person do |person|
  person.name             "Nick"
end

Factory.define :photo do |photo|
  photo.caption             "This is a test photo"
end
