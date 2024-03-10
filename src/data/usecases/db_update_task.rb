# frozen_string_literal: true

require_relative '../../core/usecases/update_task'

class DbUpdateTask
  include UpdateTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(id, updated_task)
    task = @task_repository.update(id, updated_task)
    {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
  end
end
