# frozen_string_literal: true

module UpdateTask
  # @param {Integer} id
  # @param {Task} updated_task
  def execute(id, updated_task)
    raise NotImplementedError
  end
end
