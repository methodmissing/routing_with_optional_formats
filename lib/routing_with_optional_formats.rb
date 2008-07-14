$:.unshift(File.dirname(__FILE__)) 

begin
  require 'activesupport'
rescue LoadError
  %w(rubygems activesupport action_controller).each{|l| require l }
end

require 'ac/base'
require 'ac/resources'
require 'ac/routing/route_set'

ActionController::Base.prune_routes = true if Object.const_defined?( 'Rails' ) && !Rails.env.development?