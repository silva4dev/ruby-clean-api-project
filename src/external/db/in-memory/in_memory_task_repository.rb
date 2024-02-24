# frozen_string_literal: true

require 'singleton'
require_relative '../../../data/contracts/db/task_repository'

class InMemoryTaskRepository
  include Singleton
  include TaskRepository

  def initialize
    @tasks = []
  end

  def find
    @tasks
  end

  def add(task)
    payload = {
      id: task.id,
      title: task.title,
      description: task.description,
      completed: task.completed
    }
    @tasks.push(payload)
    payload
  end

  def find_by_id(id)
    @tasks.find { |t| t[:id] == id } || nil
  end

  def update(id, updated_task)
    index = @tasks.find_index { |t| t[:id] == id }
    return nil unless index

    @tasks[index] = {
      id:,
      title: updated_task.title,
      description: updated_task.description,
      completed: updated_task.completed
    }
    @tasks[index]
  end

  def destroy(id)
    task = @tasks.find { |t| t[:id] == id }
    return nil unless task

    @tasks.delete(task)
    task
  end
end
