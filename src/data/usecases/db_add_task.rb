# frozen_string_literal: true

require_relative '../../core/usecases/add_task'

class DbAddTask
  include AddTask

  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute(task)
    @task_repository.add(task)
  end
end
