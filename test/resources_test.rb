require File.dirname(__FILE__) + '/test_helper'

class ResourceTest < Test::Unit::TestCase
  
  def setup
    @resource = ActionController::Resources::Resource.new( :articles, { :formatted => false, :member => { :vote => :put } } )
  end

  def test_should_be_able_to_determine_if_it_supports_formatted_routes
    assert_equal @resource.formatted?, false  
  end 
  
  def test_should_be_able_to_infer_its_camelized_controller
    assert_equal @resource.camelized_controller, '::ArticlesController'
  end
  
  def test_sould_be_able_to_infer_its_controller_klass
    assert_equal @resource.controller_klass, ArticlesController
  end

  def test_should_be_able_to_determine_if_its_controller_is_already_defined
    assert @resource.controller_klass?
  end

  def test_should_be_able_to_determine_if_routes_should_be_pruned
    assert @resource.prune?
  end

  def test_should_be_able_to_infer_supported_controller_actions
    assert_equal @resource.controller_actions, [:show, :index].to_set
  end
    
  def test_should_be_able_to_infer_custom_actions
    without_pruning do
      assert @resource.default_actions.include?( :vote )
    end
  end
    
  def test_should_be_able_to_infer_default_actions
    without_pruning do
      assert @resource.default_actions.include?( :index )
      assert @resource.default_actions.include?( :vote )
    end
    assert @resource.default_actions.include?( :show )
    assert @resource.default_actions.include?( :destroy )
  end
     
  def test_should_be_able_infer_all_supported_actions
    without_pruning do
      assert @resource.actions.include?( :index )
      assert @resource.actions.include?( :vote )
    end
    assert @resource.actions.include?( :index )
    assert @resource.actions.include?( :show )
    assert !@resource.actions.include?( :destroy )
  end   
  
end  

class ResourceTestControllerNotDefined < Test::Unit::TestCase
  
  def setup
    @resource = ActionController::Resources::Resource.new( :comments, {} )
  end

  def test_should_yield_default_routes
    assert @resource.actions.include?( :index )
    assert @resource.actions.include?( :destroy )
  end

  def test_should_not_raise_when_the_routes_controller_is_not_yet_defined
    assert_nothing_raised do
      ActionController::Resources::Resource.new( :users, {} )
    end
  end
  
end  