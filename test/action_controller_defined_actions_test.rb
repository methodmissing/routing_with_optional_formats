require File.dirname(__FILE__) + '/test_helper'

class ActionControllerDefinedActionsTest < Test::Unit::TestCase
  
  def setup
    @articles = ArticlesController
    @blogs = BlogsController
  end
  
  def test_should_be_able_to_infer_all_defined_controller_actions
    assert_equal @articles.actions,  [:index, :show]
    assert_equal @blogs.actions, [:show, :popular]
  end
  
end  