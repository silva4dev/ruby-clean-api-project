# frozen_string_literal: true

require_relative '../../domain/usecases/find_by_id_task'

class DbFindByIdTask
  include FindByIdTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(input)
    task = @task_repository.find_by_id(input[:id])
    return nil if task.nil?

    {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
  end
end
