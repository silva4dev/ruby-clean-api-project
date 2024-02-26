# frozen_string_literal: true

class MissingValueError < StandardError
  def initialize(attribute)
    super("#{attribute.capitalize} is required")
  end
end
