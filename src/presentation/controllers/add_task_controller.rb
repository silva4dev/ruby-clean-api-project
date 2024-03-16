# frozen_string_literal: true

require_relative '../helpers/http_helper'
require_relative '../contracts/controller'
require_relative '../../domain/models/task'

class AddTaskController
  include Controller

  def initialize(add_task_usecase, validation)
    @add_task_usecase = add_task_usecase
    @validation = validation
  end

  def handle(http_request)
    error = @validation.validate(http_request[:body])
    return HttpHelper.bad_request(error) if error

    input = {
      title: http_request[:body][:title],
      description: http_request[:body][:description]
    }
    @add_task_usecase.execute(input)
    HttpHelper.no_content
  rescue StandardError
    HttpHelper.server_error
  end
end
