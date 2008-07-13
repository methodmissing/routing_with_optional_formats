class ArticlesController < ActionController::Base
  
  before_filter :setup_article
  
  def index
  end
  
  def show
  end
  
  protected
  
  def setup_article
    @article = 'Article'
  end
  
end