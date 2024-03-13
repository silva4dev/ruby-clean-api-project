# frozen_string_literal: true

require_relative '../../../../http/controllers/destroy_task/destroy_task_controller'
require_relative '../../../../application/usecases/db_destroy_task'
require_relative '../../../../external/db/postgresql/task/pg_task_repository'

class DestroyTaskControllerFactory
  def self.create
    task_repository = PgTaskRepository.new
    db_destroy_task_usecase = DbDestroyTask.new(task_repository)
    DestroyTaskController.new(db_destroy_task_usecase)
  end
end
