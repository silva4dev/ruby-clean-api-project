# frozen_string_literal: true

require_relative '../../core/usecases/update_task'

class DbAddTask
  include UpdateTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(id, updated_task)
    @task_repository.update(id, updated_task)
  end
end
