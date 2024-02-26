# frozen_string_literal: true

require 'securerandom'
require_relative '../errors/invalid_type_error'
require_relative '../errors/missing_value_error'

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
    validate
  end

  # @return [void]
  def mark_as_completed
    @completed = true
  end

  private

  def validate
    raise InvalidTypeError.new('Title', 'String') unless title.is_a?(String)
    raise InvalidTypeError.new('Description', 'String') unless description.is_a?(String)
    raise MissingValueError, 'Title' if title.empty?
    raise MissingValueError, 'Description' if description.empty?
  end
end
