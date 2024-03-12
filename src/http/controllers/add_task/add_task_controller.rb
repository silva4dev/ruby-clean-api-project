# frozen_string_literal: true

require_relative '../../helpers/http_helper'
require_relative '../../contracts/controller'
require_relative '../../../core/models/task'

class AddTaskController
  include Controller

  # @param add_task_usecase [AddTask]
  def initialize(add_task_usecase)
    @add_task_usecase = add_task_usecase
  end

  def handle(http_request)
    title, description = http_request[:body].values_at(:title, :description)
    @add_task_usecase.execute(Task.new(title, description))
    HttpHelper.no_content
  rescue StandardError
    HttpHelper.server_error
  end
end
