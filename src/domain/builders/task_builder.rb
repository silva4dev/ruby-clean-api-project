# frozen_string_literal: true

require_relative '../models/task'

class TaskBuilder
  def initialize
    @title = nil
    @description = nil
    @completed = false
  end

  def with_title(title)
    @title = title
    self
  end

  def with_description(description)
    @description = description
    self
  end

  def with_completed(completed)
    @completed = completed
    self
  end

  def build
    task = Task.new(@title, @description)
    task.mark_as_completed(@completed)
    task
  end
end
