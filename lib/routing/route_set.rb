=begin
ActionController::Routing::RouteSet::Mapper.class_eval do

#begin      
  def connect(path, options = {})
    puts "#{path} -> #{options.inspect}"
    #return unless route_supported?( path, 'format', options )
    @set.add_route(path, options.except(:formatted))
  end        
#end
  def named_route(name, path, options = {}) #:nodoc:  
    return unless installable?( name, 'formatted', options )
    @set.add_named_route(name, path, options.except(:formatted))
  end
  
  private
  
  def installable?( element, string, options )
    options.except(:controller).empty? || ( element.include?( string ) && options[:formatted] == false ) ? false : true
  end
        
end
=end
ActionController::Routing::RouteSet.class_eval do

  def add_route(path, options = {})
    #puts "#{path} -> #{options.inspect}"
    #return unless installable?( path, options )
    route = builder.build(path, options.except(:formatted))
    @routes << route
    route
  end

  def add_named_route(name, path, options = {})
    # TODO - is options EVER used?
    return unless installable?( path, options )
    name = options[:name_prefix] + name.to_s if options[:name_prefix]
    @named_routes[name.to_sym] = add_route(path, options)
  end

  private
  
  def installable?( path, options )
    options.except(:controller).empty? || ( path.include?( 'format' ) && options[:formatted] == false ) ? false : true
  end

end