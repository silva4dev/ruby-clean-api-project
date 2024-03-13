# frozen_string_literal: true

require_relative '../../../../presentation/controllers/find_by_id_task/find_by_id_task_controller'
require_relative '../../../../application/usecases/db_find_by_id_task'
require_relative '../../../../infrastructure/db/pg/task/pg_task_repository'

class FindByIdTaskControllerFactory
  def self.create
    task_repository = PgTaskRepository.new
    db_find_by_id_task_usecase = DbFindByIdTask.new(task_repository)
    FindByIdTaskController.new(db_find_by_id_task_usecase)
  end
end
