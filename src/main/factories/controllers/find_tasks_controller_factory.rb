# frozen_string_literal: true

require_relative '../../../presentation/controllers/find_tasks_controller'
require_relative '../../../main/factories/usecases/db_find_tasks_factory'

class FindTasksControllerFactory
  def self.create
    FindTasksController.new(DbFindTasksFactory.create)
  end
end
