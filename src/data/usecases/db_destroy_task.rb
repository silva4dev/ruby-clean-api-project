# frozen_string_literal: true

require_relative '../../core/usecases/destroy_task'

class DbDestroyTask
  include DestroyTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(id)
    @task_repository.destroy(id)
  end
end
