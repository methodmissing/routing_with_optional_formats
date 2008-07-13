class BlogsController < ActionController::Base
  
  before_filter :setup_blog
  
  def show
  end
  
  def popular
  end
  
  protected
  
  def setup_blog
    @blog = 'Blog'
  end
  
end