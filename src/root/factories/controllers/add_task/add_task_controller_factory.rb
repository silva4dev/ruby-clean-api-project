# frozen_string_literal: true

require_relative '../../../../http/controllers/add_task/add_task_controller'
require_relative '../../../../data/usecases/db_add_task'
require_relative '../../../../external/db/postgresql/task/task_postgresql_repository'

class AddTaskControllerFactory
  def self.create
    task_repository = TaskPostgreSQLRepository.new
    db_add_task_usecase = DbAddTask.new(task_repository)
    AddTaskController.new(db_add_task_usecase)
  end
end
