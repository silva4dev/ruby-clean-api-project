# frozen_string_literal: true

require_relative '../../../application/usecases/db_update_task'
require_relative '../../../infrastructure/db/pg/task/pg_task_repository'

class DbUpdateTaskFactory
  def self.create
    task_repository = PgTaskRepository.new
    DbUpdateTask.new(task_repository)
  end
end
