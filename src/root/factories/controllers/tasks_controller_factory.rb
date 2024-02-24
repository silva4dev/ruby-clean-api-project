# frozen_string_literal: true

require_relative '../../adapters/route_adapter'

class TasksControllerFactory
  def self.create(controller, method_name)
    lambda do |env|
      RouteAdapter
        .adapt(controller, method_name)
        .call(env)
    end
  end
end
