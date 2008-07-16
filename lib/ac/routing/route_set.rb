ActionController::Routing::RouteSet::Mapper.class_eval do

  def connect(path, options = {})
    return if controller_only?( options )
    options.delete(:formatted)
    @set.add_route(path, options)
  end

  def named_route(name, path, options = {}) #:nodoc:
    return unless installable?( path, options )
    options.delete(:formatted)
    @set.add_named_route(name, path, options)
  end

  private
  
  def controller_only?( options )
    return false unless ActionController::Base.prune_routes
    options.except(:controller).empty?
  end

  def installable?( path, options )
    return true unless ActionController::Base.prune_routes
    controller_only?(options) || ( path.include?( 'format' ) && options[:formatted] == false ) ? false : true
  end

end