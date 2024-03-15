# frozen_string_literal: true

require_relative '../../../application/usecases/db_add_task'
require_relative '../../../infrastructure/db/pg/task/pg_task_repository'

class DbAddTaskFactory
  def self.create
    task_repository = PgTaskRepository.new
    DbAddTask.new(task_repository)
  end
end
