Churchapp::Application.routes.draw do

  resources :users do 
    collection do 
      post :validate
    end
  end
  match 'signin' => 'users#signin', :as => :signin
  match 'register' => 'users#new', :as => :register
  match '/signout' => 'users#signout', :as => :signout
  match 'download_pdf' => 'widgets#download_pdf', :as => :download_pdf

  match "/", :to => 'pages#show', :as => :parish_home
  match "/(:institution_id)/cat/:category_id", :to => 'categories#category_articles', :as => :category_articles
  
  scope '/admin/(:institution_id)' do
    resources :nav_items
    resources :nav_menus do
      resources :nav_items
    end
    resources :pages do
      resources :widgets
    end
    resources :people
    resources :churches
    resources :categories
    resources :articles do
      resources :comments
    end
    resources :events
    resources :photos   
    resources :background_images    
    resources :messages 
    resources :documents
  end
  
  resources :users do
    member do
      get :change_password
    end
  end
  
  match "/admin/(:institution_id)", :to => 'admin#church_admin', :as => :church_admin  
  match "/:institution_id", :to => 'pages#show', :as => :church_home  
  match "admin/pages/order_widgets", :to => 'pages#order_widgets', :as => :order_widgets
  match "admin/photos/order_photos", :to => 'photos#order_photos', :as => :order_photos
  match "admin/nav_menus/order_nav_items", :to => 'nav_menus#order_nav_items', :as => :order_nav_items
  match "/:institution_id/photos/:id", :to => 'photos#show', :as => :original_photo
  match "/(:institution_id)/articles/:id", :to => 'articles#show', :as => :single_article
  
  match "/(:institution_id)/pages/:id", :to => 'pages#show', :as => :church_page
  match "/events/series/:id", :to => 'events#series', :as => :events_series
  get "calendar/index"
  get "calendar/other_month"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
