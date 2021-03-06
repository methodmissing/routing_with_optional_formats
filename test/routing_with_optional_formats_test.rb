require File.dirname(__FILE__) + '/test_helper'

class RoutingWithOptionalFormatsTest < Test::Unit::TestCase
  
  def setup
    self.class.send :include, ActionController::UrlWriter 
    ActionController::Base.prune_routes = true
  end
  
  def test_should_not_define_formatted_routes_when_explicitly_disabled
    assert_named_route( "/articles", :articles_path )
    assert_raise( NoMethodError ) do
      assert_named_route( "/articles.xml", :formatted_articles_path, { :format => :xml } )
    end
    assert_named_route( "/users", :users_path )
    assert_named_route( "/users.xml", :formatted_users_path, { :format => :xml } )    
  end

  def test_should_be_able_to_define_only_a_subset_of_actions
    assert_named_route( "/blogs/1", :blog_path, { :id => 1 } )
    assert_raise( NoMethodError ) do
      assert_named_route( "/articles/1/edit", :edit_article_path, { :id => 1 } )
    end
    assert_named_route( "/blogs/popular", :popular_blogs_path )
    assert_named_route( "/blogs", :blogs_path )
    assert_named_route("/photos/1/vote", :vote_photo_path, { :id => 1 })
    assert_named_route( "/photos", :photos_path )
    assert_named_route( "/photos/1", :photo_path, { :id => 1 } )
    assert_raise( NoMethodError ) do
      assert_named_route( "/blogs/1/edit", :edit_blog_path, { :id => 1 } )
    end
  end

  def assert_named_route(expected, route, options = {})
    actual = send(route, options)
    assert_equal expected, actual, "Error on route: #{route}(#{options.inspect})"
  end

end