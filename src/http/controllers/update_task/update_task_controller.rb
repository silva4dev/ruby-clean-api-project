# frozen_string_literal: true

require_relative '../../helpers/http_helper'
require_relative '../../contracts/controller'
require_relative '../../../core/models/task'

class UpdateTaskController
  include Controller

  # @param update_task_usecase [UpdateTask]
  def initialize(update_task_usecase)
    @update_task_usecase = update_task_usecase
  end

  def handle(http_request)
    title = http_request[:body][:title]
    description = http_request[:body][:description]
    completed = http_request[:body][:completed]
    task = Task.new(title, description)
    task.mark_as_completed(completed)
    result = @update_task_usecase.execute(http_request[:params][:id], task)
    return HttpHelper.not_found if result.nil?

    HttpHelper.no_content
  rescue StandardError
    HttpHelper.server_error
  end
end
