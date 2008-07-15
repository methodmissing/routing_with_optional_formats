ActionController::Routing::Routes.draw do |map|
  map.resources :articles, :formatted => false
  map.resources :users
  map.resources :blogs, :collection => { :popular => :get }
  map.resources :photos, :member => { :vote => :put }
  map.namespace(:admin) do |admin|
    admin.resources :blogs, :formatted => false
  end
end