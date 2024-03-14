# frozen_string_literal: true

module TaskRepository
  def find
    raise NotImplementedError
  end

  def add(task)
    raise NotImplementedError
  end

  def find_by_id(id)
    raise NotImplementedError
  end

  def update(id, updated_task)
    raise NotImplementedError
  end

  def destroy(id)
    raise NotImplementedError
  end
end
