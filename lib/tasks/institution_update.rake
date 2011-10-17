namespace :institution do

  task :update => :environment do
    Event.all.each do |event|
    	if event.respond_to?(:church_id)
    		event.update_attributes(:institution_id => event.church_id)
    	elsif event.respond_to?(:parish_id)
    		event.update_attributes(:institution_id => event.parish_id)
    	end
    end
    
    Page.all.each do |page|
    	if page.respond_to?(:church_id)
    		page.update_attributes(:institution_id => page.church_id)
    	elsif page.respond_to?(:parish_id)
    		page.update_attributes(:institution_id => page.parish_id)
    	end
    end    

    Photo.all.each do |photo|
    	if photo.respond_to?(:church_id)
    		photo.update_attributes(:institution_id => photo.church_id)
    	elsif photo.respond_to?(:parish_id)
    		photo.update_attributes(:institution_id => photo.parish_id)
    	end
    end    

    NavMenu.all.each do |nav_menu|
    	if nav_menu.respond_to?(:church_id)
    		nav_menu.update_attributes(:institution_id => nav_menu.church_id)
    	elsif nav_menu.respond_to?(:parish_id)
    		nav_menu.update_attributes(:institution_id => nav_menu.parish_id)
    	end
    end        

    NavItem.all.each do |nav_item|
    	if nav_item.respond_to?(:church_id)
    		nav_item.update_attributes(:institution_id => nav_item.church_id)
    	elsif nav_item.respond_to?(:parish_id)
    		nav_item.update_attributes(:institution_id => nav_item.parish_id)
    	end
    end        

    Article.all.each do |article|
    	if article.respond_to?(:church_id)
    		article.update_attributes(:institution_id => article.church_id)
    	elsif article.respond_to?(:parish_id)
    		article.update_attributes(:institution_id => article.parish_id)
    	end
    end        

    EventSeries.all.each do |event_series|
    	if event_series.respond_to?(:church_id)
    		event_series.update_attributes(:institution_id => event_series.church_id)
    	elsif event_series.respond_to?(:parish_id)
    		event_series.update_attributes(:institution_id => event_series.parish_id)
    	end
    end   

    Person.all.each do |person|
    	if person.respond_to?(:church_id)
    		person.update_attributes(:institution_id => person.church_id)
    	elsif person.respond_to?(:parish_id)
    		person.update_attributes(:institution_id => person.parish_id)
    	end
    end        

    User.all.each do |user|
    	if user.respond_to?(:church_id)
    		user.update_attributes(:institution_id => user.church_id)
    	elsif user.respond_to?(:parish_id)
    		user.update_attributes(:institution_id => user.parish_id)
    	end
    end        

    Message.all.each do |message|
    	if message.respond_to?(:church_id)
    		message.update_attributes(:institution_id => message.church_id)
    	elsif message.respond_to?(:parish_id)
    		message.update_attributes(:institution_id => message.parish_id)
    	end
    end        
    
  end
  
end