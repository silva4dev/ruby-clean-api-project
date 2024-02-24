# frozen_string_literal: true

require 'securerandom'

class Task
  attr_reader :id, :title, :description, :completed

  def initialize(title, description)
    @id = SecureRandom.uuid
    @title = title
    @description = description
    @completed = false
  end

  def mark_as_completed
    @completed = true
  end
end
