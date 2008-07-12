ActionController::Routing::RouteSet::Mapper.class_eval do
        
  def connect(path, options = {})
    return unless route_supported?( path, 'format', options )
    @set.add_route(path, options.except(:formatted))
  end        
        
  def named_route(name, path, options = {}) #:nodoc:
    return unless route_supported?( name, 'formatted', options )
    @set.add_named_route(name, path, options.except(:formatted))
  end
  
  private
  
  def route_supported?( element, string, options )
    options.except(:controller).empty? || ( element.include?( string ) && options[:formatted] == false ) ? false : true
  end
        
end