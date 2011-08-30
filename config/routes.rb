ArtistManager::Application.routes.draw do

  # passwords
  get   "change_password_request" => "passwords#new"
  post  "change_password_request" => "passwords#create"
  get   "change_password" => "passwords#edit"
  get   "edit_account" => "passwords#edit"
  put   "change_password" => "passwords#update"

  # payments
  get  "payments/checkout"
  get  "payments/confirm"
  post "payments/complete"

  resources :series, :only => [:show, :new, :create, :edit, :update, :destroy]

  resources :sessions, :only => :create
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"

  resources :users, :only => [:edit, :update]
  
  resources :work do
    get :autocomplete_tag_name, :on => :collection
    post :price_request
    resources :work_images, :shallow => true, :only => [:index, :create, :destroy]
  end

  # settings
  get 'settings' => 'settings#edit', :as => :edit_settings
  put 'settings' => 'settings#update'

  get 'events' => 'home#events'
  get 'home' => 'home#show'
  root :to => 'home#splash'
  
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
  # match ':controller(/:action(/:id(.:format)))'
end
