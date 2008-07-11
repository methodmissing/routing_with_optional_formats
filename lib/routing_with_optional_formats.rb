$:.unshift(File.dirname(__FILE__)) 

begin
  require 'activesupport'
rescue LoadError
  %w(rubygems activesupport action_controller).each{|l| require l }
  require 'action_controller/routing'
end

require 'resources'
require 'routing/route_set'