# frozen_string_literal: true

class InvalidTypeError < StandardError
  def initialize(attribute, expected_type)
    super("#{attribute.capitalize} must be of type #{expected_type}")
    @name = 'InvalidTypeError'
  end
end
