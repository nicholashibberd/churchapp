Churchapp::Application.routes.draw do

  resources :users do 
    collection do 
      post :validate
    end
  end
  
  match 'advent_calendar' => 'pages#advent_calendar', :as => :advent_calendar
  match 'signin' => 'users#signin', :as => :signin
  match 'register' => 'users#new', :as => :register
  match '/signout' => 'users#signout', :as => :signout
  match 'download_pdf' => 'widgets#download_pdf', :as => :download_pdf
  match "update_site_info", :to => 'admin#update_site_info', :via => 'post', :as => :update_site_info

  match "/", :to => 'pages#show', :as => :root
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
    #resources :churches
    resources :categories
    resources :articles do
      resources :comments
    end
    resources :events
    resources :photos   
    resources :background_images    
    resources :messages 
    resources :forms do
      resources :form_records
    end
    resources :documents
  end
  
  resources :users do
    member do
      get :change_password
    end
  end
  
  #post 'form_records/create'
  
  match "admin/site_information", :to => 'admin#site_information', :as => :site_information
  match "/admin/(:institution_id)", :to => 'admin#church_admin', :as => :church_admin  
  match "/:institution_id", :to => 'pages#show', :as => :church_home  
  match "admin/pages/order_widgets", :to => 'pages#order_widgets', :as => :order_widgets
  match "admin/pages/position_widgets", :to => 'pages#position_widgets', :as => :position_widgets
  match "admin/pages/set_widget_area_height", :to => 'pages#set_widget_area_height', :as => :set_widget_area_height
  match "admin/photos/order_photos", :to => 'photos#order_photos', :as => :order_photos
  match "admin/nav_menus/order_nav_items", :to => 'nav_menus#order_nav_items', :as => :order_nav_items
  match "/:institution_id/photos/:id", :to => 'photos#show', :as => :original_photo
  match "/(:institution_id)/articles/:id", :to => 'articles#show', :as => :single_article
  
  match "/(:institution_id)/pages/:id", :to => 'pages#show', :as => :church_page
  match "/events/series/:id", :to => 'events#series', :as => :events_series
  get "calendar/index"
  get "calendar/other_month"
  
  match '*path', :to => 'application#page_not_found'  

end
