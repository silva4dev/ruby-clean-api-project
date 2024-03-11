# frozen_string_literal: true

require 'grape'
require_relative '../../adapters/route_adapter'
require_relative '../../factories/controllers/find_tasks/find_tasks_controller_factory'
require_relative '../../factories/controllers/find_by_id_task/find_by_id_task_controller_factory'

class TasksRoute < Grape::API
  namespace :tasks do
    get '/' do
      http_response = RouteAdapter.adapt(FindTasksControllerFactory.create).call(request)
      status http_response[:status_code]
      http_response[:body]
    end

    get '/:id' do
      http_response = RouteAdapter.adapt(FindByIdTaskControllerFactory.create).call(request)
      status http_response[:status_code]
      http_response[:body]
    end
  end
end
