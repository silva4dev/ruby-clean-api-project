# frozen_string_literal: true

require_relative '../helpers/http_helper'
require_relative '../contracts/controller'
require_relative '../../domain/models/task'

class UpdateTaskController
  include Controller

  def initialize(update_task_usecase)
    @update_task_usecase = update_task_usecase
  end

  def handle(http_request)
    input = {
      id: http_request[:params][:id],
      title: http_request[:body][:title],
      description: http_request[:body][:description],
      completed: http_request[:body][:completed]
    }
    task = @update_task_usecase.execute(input)
    return HttpHelper.not_found if task.nil?

    HttpHelper.no_content
  rescue StandardError
    HttpHelper.server_error
  end
end
