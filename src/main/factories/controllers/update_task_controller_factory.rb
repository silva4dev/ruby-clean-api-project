# frozen_string_literal: true

require_relative '../../../presentation/controllers/update_task_controller'
require_relative '../../../main/factories/usecases/db_update_task_factory'
require_relative '../../../main/factories/validations/update_task_validation_factory'

class UpdateTaskControllerFactory
  def self.create
    UpdateTaskController.new(DbUpdateTaskFactory.create, UpdateTaskValidationFactory.create)
  end
end
