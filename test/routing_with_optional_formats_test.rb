require 'init'
require 'test/unit'

ActionController::Routing::Routes.draw do |map|
  map.resources :articles, :formatted => false
  map.resources :users
end

class RoutingWithOptionalFormatsTest < Test::Unit::TestCase
  
  def setup
    self.class.send :include, ActionController::UrlWriter 
  end
  
  def test_should_not_define_formatted_routes_when_explicitly_disabled
    assert_named_route( "/articles", :articles_path )
    assert_raise( NoMethodError ) do
      assert_named_route( "/articles.xml", :formatted_articles_path, { :format => :xml } )
    end
    assert_named_route( "/users", :users_path )
    assert_named_route( "/users.xml", :formatted_users_path, { :format => :xml } )    
  end
  
  def assert_named_route(expected, route, options = {})
    actual =  send(route, options)
    assert_equal expected, actual, "Error on route: #{route}(#{options.inspect})"
  end

end