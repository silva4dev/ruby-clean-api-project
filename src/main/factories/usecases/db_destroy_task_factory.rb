# frozen_string_literal: true

require_relative '../../../application/usecases/db_destroy_task'
require_relative '../../../infrastructure/db/pg/task/pg_task_repository'

class DbDestroyTaskFactory
  def self.create
    task_repository = PgTaskRepository.new
    DbDestroyTask.new(task_repository)
  end
end
