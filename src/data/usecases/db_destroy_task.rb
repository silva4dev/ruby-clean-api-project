# frozen_string_literal: true

require_relative '../../core/usecases/destroy_task'

class DbDestroyTask
  include DestroyTask

  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(id)
    task = @task_repository.destroy(id)
    raise StandardError("Task with id #{id} not found") if task.nil?

    nil
  end
end
