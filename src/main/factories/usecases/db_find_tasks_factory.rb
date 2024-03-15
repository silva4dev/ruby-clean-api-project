# frozen_string_literal: true

require_relative '../../../application/usecases/db_find_tasks'
require_relative '../../../infrastructure/db/pg/task/pg_task_repository'

class DbFindTasksFactory
  def self.create
    task_repository = PgTaskRepository.new
    DbFindTasks.new(task_repository)
  end
end
