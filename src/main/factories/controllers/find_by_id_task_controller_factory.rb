# frozen_string_literal: true

require_relative '../../../presentation/controllers/find_by_id_task_controller'
require_relative '../../../main/factories/usecases/db_find_by_id_task_factory'

class FindByIdTaskControllerFactory
  def self.create
    FindByIdTaskController.new(DbFindByIdTaskFactory.create)
  end
end
