ActionController::Routing::Routes.draw do |map|
  map.resources :group_pictures

  map.resources :pictures

  map.resources :articles

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users

  map.resource :session

  map.root :controller => 'home', :action => 'index'

  map.resources :users
  map.resource  :session
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.namespace :admin do |admin|
    admin.root :controller => 'home'
    admin.resources :home
    admin.resources :articles, :active_scaffold => true
    admin.resources :categories, :active_scaffold => true
    admin.resources :comments, :active_scaffold => true
    admin.resources :group_pictures, :active_scaffold => true
    admin.resources :pictures, :active_scaffold => true
    admin.resources :users, :active_scaffold => true
    admin.resources :reference_materials, :active_scaffold => true #do |reference_material|
    #  reference_material.resources :attachments, :active_scaffold => true
    #end
  end

  map.resources :reference_materials, :path => 'materiales', :collection => { :practico => :get, :teorico => :get } do |reference_materials|
    reference_materials.resources :comments
  end
  map.resources :groups, :path => 'talleres'
  map.resources :about_us, :path => 'acerca_de'
  map.resources :contact_us, :path => 'contacto'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
