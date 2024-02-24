# frozen_string_literal: true

module TaskRepository
  def find
    raise NotImplementedError
  end

  # @param {Task} task
  def add(task)
    raise NotImplementedError
  end

  # @param {Integer} id
  def find_by_id(id)
    raise NotImplementedError
  end

  # @param {Integer} id
  # @param {Task} updated_task
  def update(id, updated_task)
    raise NotImplementedError
  end

  # @param {Integer} id
  def destroy(id)
    raise NotImplementedError
  end
end
