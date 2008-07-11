ActionController::Routing::RouteSet::Mapper.class_eval do
        
  def named_route(name, path, options = {}) #:nodoc:
    return if name.include?( 'formatted' ) && options[:formatted] == false
    @set.add_named_route(name, path, options)
  end
        
end