# frozen_string_literal: true

require_relative '../../domain/usecases/destroy_task'

class DbDestroyTask
  include DestroyTask

  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(input)
    task = @task_repository.find_by_id(input[:id])
    return nil if task.nil?

    @task_repository.destroy(input[:id])
    {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
  end
end
