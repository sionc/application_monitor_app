# Copyright © Adept Technology, Inc. All rights reserved.
# $URL: svn://subversion.adept.local/ApplicationMonitor/src/trunk/ApplicationMonitor.WebApp/config/routes.rb $
# $Revision: 41 $, $Date: 2013-03-15 12:09:33 -0700 (Fri, 15 Mar 2013) $
#
# The change history for this file is located in svn and can be viewed using the svn utilities.

ApplicationMonitorApp::Application.routes.draw do
  get "pages/dashboard"
  get "pages/calendar"
  get "pages/faq"
  get "pages/index"
  get "pages/login"
  get "pages/messages"
  get "pages/paragraphs"
  get "pages/profile"
  get "pages/settings"
  get "pages/stream"
  get "pages/users"

  root :to => 'pages#dashboard'
  
  resources :systems, :only => [:index, :show]
  
  resources :sessions, :only => [:index, :show]

  resources :session_log_entries, :only => [:index, :show] do
    collection do
      post 'upload'
    end
  end

  resources :event_log_entries, :only => [:index, :show] do
    collection do
      post 'upload'
    end
  end
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
