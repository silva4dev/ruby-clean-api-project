# frozen_string_literal: true

require_relative '../../../application/usecases/db_find_by_id_task'
require_relative '../../../infrastructure/db/pg/task/pg_task_repository'

class DbFindByIdTaskFactory
  def self.create
    task_repository = PgTaskRepository.new
    DbFindByIdTask.new(task_repository)
  end
end
