# frozen_string_literal: true

require_relative '../../domain/usecases/find_tasks'

class DbFindTasks
  include FindTasks

  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute
    return [] if @task_repository.find.nil?

    @task_repository.find.map do |task|
      {
        id: task.id,
        title: task.title,
        description: task.description,
        completed: task.completed
      }
    end
  end
end
