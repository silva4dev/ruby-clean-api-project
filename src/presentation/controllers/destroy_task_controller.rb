# frozen_string_literal: true

require_relative '../helpers/http_helper'
require_relative '../contracts/controller'
require_relative '../../domain/models/task'

class DestroyTaskController
  include Controller

  # @param destroy_task_usecase [DestroyTask]
  def initialize(destroy_task_usecase)
    @destroy_task_usecase = destroy_task_usecase
  end

  def handle(http_request)
    input = { id: http_request[:params][:id] }
    task = @destroy_task_usecase.execute(input)
    return HttpHelper.not_found if task.nil?

    HttpHelper.no_content
  rescue StandardError
    HttpHelper.server_error
  end
end
