ActionController::Resources::Resource.class_eval do
  
  class << self
    
    def default_actions
      Set.new( [:index, :new, :create, :show, :edit, :update, :destroy] )
    end
    
  end
  
  def controller_klass
    return unless controller_klass?
    @controller_klass
  end
  
  def controller_klass?
    begin
      @controller_klass ||= camelized_controller.constantize
    rescue 
      ActionController::Base.logger.info " ** #{camelized_controller} not yet defined.Using default routes."
      false
    end
  end
  
  def formatted?
    options_with_default( :formatted )
  end  
  
  def actions
    ( prune? && controller_klass? ) ? controller_actions : default_actions
  end

  def controller_actions
    controller_klass.actions
  end
        
  def default_actions
    self.class.default_actions.union( custom_actions )
  end

  def custom_actions
    @custom_actions ||= Set.new( (@collection_methods.values + @member_methods.values + @new_methods.values ).flatten.uniq )
  end

  def prune?
    ActionController::Base.prune_routes    
  end
  
  def action?( action )
    actions.include?( action )
  end
  
  def camelized_controller
    @camelized_controller ||= "#{controller}_controller".camelize
  end  
  
  private
  
  def options_with_default( key )
    @options.key?(key) ? @options[key] : true 
  end
    
end

ActionController::Resources.module_eval do

  private
    
  def action_options_for_with_formatted( action, resource, method = nil )
    return {} unless resource.action?( action.to_sym )
    returning( action_options_for_without_formatted( action, resource, method = nil ) ) do |action_options|
      action_options.merge!( :formatted => resource.formatted? )
    end       
  end    

  alias_method_chain :action_options_for, :formatted
  
end