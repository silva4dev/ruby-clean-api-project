# frozen_string_literal: true

require_relative '../../core/usecases/find_tasks'

class DbFindTasks
  include FindTasks

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute
    @task_repository.find
  end
end
