ActionController::Routing::Routes.draw do |map|
  map.resources :articles, :formatted => false
  map.resources :users
  map.resources :blogs, :collection => { :popular => :get }, :only => :show
  map.resources :photos, :member => { :vote => :put }, :except => :edit
end