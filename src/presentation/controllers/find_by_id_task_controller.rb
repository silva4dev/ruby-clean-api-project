# frozen_string_literal: true

require_relative '../helpers/http_helper'
require_relative '../contracts/controller'

class FindByIdTaskController
  include Controller

  # @param find_by_id_task_usecase [FindByIdTask]
  def initialize(find_by_id_task_usecase)
    @find_by_id_task_usecase = find_by_id_task_usecase
  end

  def handle(http_request)
    input = { id: http_request[:params][:id] }
    task = @find_by_id_task_usecase.execute(input)
    return HttpHelper.not_found if task.nil?

    HttpHelper.ok(
      {
        id: task[:id],
        title: task[:title],
        description: task[:description],
        completed: task[:completed]
      }
    )
  rescue StandardError
    HttpHelper.server_error
  end
end
