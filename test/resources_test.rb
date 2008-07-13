require File.dirname(__FILE__) + '/test_helper'

class ResourceTest < Test::Unit::TestCase
  
  def setup
    @resource = ActionController::Resources::Resource.new( :articles, { :formatted => false, :only => [:index], :except => [:destroy] } )
  end

  def test_should_be_able_to_determine_if_it_supports_formatted_routes
    assert_equal @resource.formatted?, false  
  end 
  
  def test_sould_be_able_to_infer_its_controller_klass
    assert_equal @resource.controller_klass, ArticlesController
  end
  
  def test_should_be_able_to_yield_its_actions_to_map
    assert_equal @resource.only, [:index]
  end

  def test_should_be_able_to_yield_its_actions_to_exclude_from_mapping
    assert_equal @resource.except, [:destroy]
  end

  def test_should_be_able_to_determine_if_theres_inclusive_actions_to_map
    assert @resource.only?
  end
  
  def test_should_be_able_to_determine_if_theres_exclusive_actions_to_map
    assert @resource.except?
  end  
  
  def test_should_be_able_to_infer_supported_controller_actions
    assert_equal @resource.controller_actions, [:show, :index]
  end
  
end  