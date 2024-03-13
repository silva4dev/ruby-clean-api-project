# frozen_string_literal: true

require_relative '../../../presentation/controllers/update_task_controller'
require_relative '../../../application/usecases/db_update_task'
require_relative '../../../infrastructure/db/pg/task/pg_task_repository'

class UpdateTaskControllerFactory
  def self.create
    task_repository = PgTaskRepository.new
    db_update_task_usecase = DbUpdateTask.new(task_repository)
    UpdateTaskController.new(db_update_task_usecase)
  end
end
