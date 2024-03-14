# frozen_string_literal: true

require_relative '../helpers/http_helper'
require_relative '../contracts/controller'
require_relative '../../domain/models/task'

class AddTaskController
  include Controller

  # @param add_task_usecase [AddTask]
  def initialize(add_task_usecase)
    @add_task_usecase = add_task_usecase
  end

  def handle(http_request)
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
