# frozen_string_literal: true

require 'securerandom'
require_relative '../errors/invalid_type_error'
require_relative '../errors/missing_param_error'

class Task
  attr_reader :id
  attr_accessor :title, :description, :completed

  def initialize(title, description)
    @id = SecureRandom.uuid
    @title = title
    @description = description
    @completed = false
    validate
  end

  def mark_as_completed(completed = true)
    @completed = completed
  end

  private

  def validate
    raise InvalidTypeError.new('Title', 'String') unless @title.is_a?(String)
    raise InvalidTypeError.new('Description', 'String') unless @description.is_a?(String)
    raise MissingParamError, 'Title is required' if @title.empty?
    raise MissingParamError, 'Description is required' if @description.empty?
  end
end
