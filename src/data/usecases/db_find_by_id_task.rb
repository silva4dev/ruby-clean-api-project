# frozen_string_literal: true

require_relative '../../core/usecases/find_by_id_task'

class DbFindByIdTask
  include FindByIdTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(id)
    task = @task_repository.find_by_id(id)
    {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
  end
end
