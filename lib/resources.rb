ActionController::Resources::Resource.class_eval do
  
  def formatted?
    @options[:formatted]
  end  
  
  def only
    Array( @options[:only] )
  end

  def only?
    !only.empty?
  end
  
  def except
    Array( @options[:except] )
  end
  
  def except?
    !except.empty?
  end
  
  def actions
    if only? 
      only + sanitized_custom_actions
    elsif except?
      all_actions - except
    else
      all_actions
    end
  end
  
  def action?( action )
    actions.include?( action )
  end
  
  private
  
  def custom_actions
    returning([]) do |custom|
      custom.concat @collection_methods.values
      custom.concat @member_methods.values
      custom.concat @new_methods.values
    end.flatten    
  end
  
  def sanitized_custom_actions
    custom_actions - [:edit, :new]
  end
  
  def default_actions
    [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  
  def all_actions
    ( default_actions + sanitized_custom_actions ).uniq
  end
  
end

ActionController::Resources.module_eval do

  def resources(*entities, &block)
    options = entities.extract_options!
    options.reverse_merge!( :formatted => true, :only => [], :except => [] )
    entities.each { |entity| map_resource(entity, options.dup, &block) }
  end

  def resource(*entities, &block)
    options = entities.extract_options!
    options.reverse_merge!( :formatted => true, :only => [], :except => [] )
    entities.each { |entity| map_singleton_resource(entity, options.dup, &block) }
  end

  private
  
  def action_options_for_with_formatted( action, resource, method = nil )
    #puts resource.actions.inspect
    return {} unless resource.action?( action.to_sym )
    returning( action_options_for_without_formatted( action, resource, method = nil ) ) do |action_options|
      action_options.merge!( :formatted => resource.formatted? )
    end       
  end    

  alias_method_chain :action_options_for, :formatted
  
end