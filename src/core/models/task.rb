# frozen_string_literal: true

require 'securerandom'

class Task
  # @return [String]
  attr_reader :id
  # @return [String]
  attr_reader :title
  # @return [String]
  attr_reader :description
  # @return [Boolean]
  attr_reader :completed

  # @param {String} title
  # @param {String} description
  def initialize(title, description)
    @id = SecureRandom.uuid
    @title = title
    @description = description
    @completed = false
  end

  # @return [void]
  def mark_as_completed
    @completed = true
  end
end
