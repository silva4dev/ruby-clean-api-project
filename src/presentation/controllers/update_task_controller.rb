# frozen_string_literal: true

require_relative '../helpers/http_helper'
require_relative '../contracts/controller'
require_relative '../../domain/models/task'

class UpdateTaskController
  include Controller

  def initialize(update_task_usecase, validation)
    @update_task_usecase = update_task_usecase
    @validation = validation
  end

  def handle(http_request)
    error = @validation.validate(http_request[:body])
    return HttpHelper.bad_request(error) if error

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
