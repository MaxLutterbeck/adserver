ActionController::Routing::Routes.draw do |map|

map.root :controller => "ads", :action => "index"

# begin restful_authentication routes …
map.login  '/login',  :controller => 'sessions', :action => 'new'
map.logout '/logout', :controller => 'sessions', :action => 'destroy'
map.signup '/signup', :controller => 'users', :action => 'new'
map.activate '/activate/:id', :controller => 'user_accounts', :action => 'show'
map.change_password '/change_password',   :controller => 'user_accounts', :action => 'edit'
map.forgot_password '/forgot_password',   :controller => 'passwords', :action => 'new'
map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'

map.resources :users, :member => { :enable => :put } do |users|
users.resource :user_account
users.resources :roles
end

map.resource :session
map.resource :password
# … end restful_authentication routes

map.resources :ads
map.resources :image_ads
map.resources :flash_ads

# Install the default routes as the lowest priority.
map.connect ':controller/:action/:id'
map.connect ':controller/:action/:id.:format'

end