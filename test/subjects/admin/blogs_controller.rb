class Admin::BlogsController < ActionController::Base
  
  before_filter :setup_blog
  
  def index
  end
  
  def show
  end
  
  def destroy
  end
  
  protected
  
  def setup_blog
    @blog = 'Blog'
  end
  
end