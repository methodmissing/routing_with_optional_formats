ActionController::Routing::RouteSet::Mapper.class_eval do
        
  def connect(path, options = {})
    return if path.include?( 'format' ) && options[:formatted] == false
    @set.add_route(path, options)
  end        
        
  def named_route(name, path, options = {}) #:nodoc:
    return if name.include?( 'formatted' ) && options[:formatted] == false
    @set.add_named_route(name, path, options)
  end
        
end