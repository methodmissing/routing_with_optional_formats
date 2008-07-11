ActionController::Resources::Resource.class_eval do
  
  def formatted?
    @options[:formatted]
  end  
  
end

ActionController::Resources.module_eval do

  def resources(*entities, &block)
    options = entities.extract_options!
    options.reverse_merge!( :formatted => true )
    entities.each { |entity| map_resource(entity, options.dup, &block) }
  end

  def resource(*entities, &block)
    options = entities.extract_options!
    options.reverse_merge!( :formatted => true )
    entities.each { |entity| map_singleton_resource(entity, options.dup, &block) }
  end
  
  private
  
  def action_options_for_with_formatted( action, resource, method = nil )
    returning( action_options_for_without_formatted( action, resource, method = nil ) ) do |action_options|
      action_options.merge!( :formatted => resource.formatted? )
    end       
  end    

  alias_method_chain :action_options_for, :formatted
  
end