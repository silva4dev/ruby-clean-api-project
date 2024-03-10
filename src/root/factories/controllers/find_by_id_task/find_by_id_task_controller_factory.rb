# frozen_string_literal: true

require_relative '../../../../http/controllers/find_by_id_task/find_by_id_task_controller'
require_relative '../../../../data/usecases/db_find_by_id_task'
require_relative '../../../../external/db/postgresql/task/task_postgresql_repository'

class FindByIdTaskControllerFactory
  def self.create
    task_repository = TaskPostgreSQLRepository.new
    db_find_by_id_task_usecase = DbFindByIdTask.new(task_repository)
    FindByIdTaskController.new(db_find_by_id_task_usecase)
  end
end
