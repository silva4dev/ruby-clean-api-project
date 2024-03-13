# frozen_string_literal: true

require_relative '../../../../presentation/controllers/add_task/add_task_controller'
require_relative '../../../../application/usecases/db_add_task'
require_relative '../../../../infrastructure/db/pg/task/pg_task_repository'

class AddTaskControllerFactory
  def self.create
    task_repository = PgTaskRepository.new
    db_add_task_usecase = DbAddTask.new(task_repository)
    AddTaskController.new(db_add_task_usecase)
  end
end
