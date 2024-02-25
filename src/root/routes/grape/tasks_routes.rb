# frozen_string_literal: true

require 'grape'
require_relative '../../adapters/route_adapter'
require_relative '../../factories/controllers/find_tasks/find_tasks_controller_factory'

class TasksRoute < Grape::API
  get :tasks do
    http_response = RouteAdapter.adapt(FindTasksControllerFactory.create).call(request)
    status http_response[:status_code]
    present http_response[:body]
  end
end
