# frozen_string_literal: true

require_relative '../../domain/usecases/update_task'

class DbUpdateTask
  include UpdateTask

  # @param task_repository [TaskRepository]
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(input)
    task = @task_repository.find_by_id(input[:id])
    return nil if task.nil?

    task.title = input[:title].nil? ? task.title : input[:title]
    task.description = input[:description].nil? ? task.description : input[:description]
    task.completed = input[:completed].nil? ? task.completed : input[:completed]
    @task_repository.update(input[:id], task)
    {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
  end
end
