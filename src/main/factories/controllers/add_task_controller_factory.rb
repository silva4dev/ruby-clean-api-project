# frozen_string_literal: true

require_relative '../../../presentation/controllers/add_task_controller'
require_relative '../../../main/factories/validations/add_task_validation_factory'
require_relative '../../../main/factories/usecases/db_add_task_factory'

class AddTaskControllerFactory
  def self.create
    AddTaskController.new(DbAddTaskFactory.create, AddTaskValidationFactory.create)
  end
end
