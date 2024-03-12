# frozen_string_literal: true

require_relative '../../helpers/http_helper'
require_relative '../../contracts/controller'

class FindTasksController
  include Controller

  # @param find_tasks_usecase [FindTasks]
  def initialize(find_tasks_usecase)
    @find_tasks_usecase = find_tasks_usecase
  end

  def handle(http_request)
    tasks = @find_tasks_usecase.execute
    HttpHelper.ok({ tasks: })
  rescue StandardError
    HttpHelper.server_error
  end
end
