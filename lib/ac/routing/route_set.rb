ActionController::Routing::RouteSet.class_eval do

  def add_route(path, options = {})
    options.delete(:formatted)
    route = builder.build(path, options)
    @routes << route
    route
  end

  def connect(path, options = {})
    if installable?( path, options )
      @set.add_route(path, options)
    end  
  end

  def add_named_route(name, path, options = {})
    if installable?( path, options )
      name = options[:name_prefix] + name.to_s if options[:name_prefix]
      @named_routes[name.to_sym] = add_route(path, options)
    end
  end

  private
  
  def installable?( path, options )
    if options[:controller] && options[:action]
      klass = klass_from_options( options )   
      return false unless klass.actions.include?( options[:action].to_sym )
    end
    options.except(:controller).empty? || ( path.include?( 'format' ) && options[:formatted] == false ) ? false : true
  end

  def klass_from_options( options )
    begin
      "#{options[:controller].camelize}Controller".constantize
    rescue
      "#{options[:controller].classify}Controller".constantize
    end
  end  
 
end
