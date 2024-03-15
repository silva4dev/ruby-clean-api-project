# frozen_string_literal: true

require_relative '../../../presentation/controllers/destroy_task_controller'
require_relative '../../../main/factories/usecases/db_destroy_task_factory'

class DestroyTaskControllerFactory
  def self.create
    DestroyTaskController.new(DbDestroyTaskFactory.create)
  end
end
