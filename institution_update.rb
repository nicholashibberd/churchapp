Event.all.each do |event|
	if event.respond_to?(:church_id)
		event.update_attributes(:institution_id => event.church_id)
	elsif event.respond_to?(:parish_id)
		event.update_attributes(:institution_id => event.parish_id)
	end
end