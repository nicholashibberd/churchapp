authorization do
  role :administrator do
    has_permission_on [:pages, :people, :articles, :events, :photos, :nav_menus, :messages, :users, :documents], :to => :manage
  end
  
  role :author do    
    has_permission_on [:pages, :articles, :events, :documents], :to => :append
  end  
    
  role :read_only do
    has_permission_on [:pages, :people, :articles, :events, :photos, :nav_menus, :messages, :users, :documents], :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :append, :includes => [:create, :read, :update]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end