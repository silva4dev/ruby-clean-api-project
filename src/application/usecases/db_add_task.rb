# frozen_string_literal: true

require_relative '../../domain/usecases/add_task'

class DbAddTask
  include AddTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(input)
    task = Task.new(input[:title], input[:description])
    @task_repository.add(task)
    {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
  end
end
