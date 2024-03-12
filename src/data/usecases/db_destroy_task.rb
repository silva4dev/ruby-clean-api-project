# frozen_string_literal: true

require_relative '../../core/usecases/destroy_task'

class DbDestroyTask
  include DestroyTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(id)
    task = @task_repository.destroy(id)
    return nil if task.nil?

    {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
  end
end
