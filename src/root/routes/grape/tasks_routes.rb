# frozen_string_literal: true

require 'grape'
require_relative '../../../http/controllers/tasks_controller'
require_relative '../../factories/controllers/tasks_controller_factory'

class TasksRoute < Grape::API
  get :tasks do
    http_response = TasksControllerFactory.create(TasksController.new, :find).call(request)
    status http_response[:status_code]
    present http_response[:body]
  end
end
