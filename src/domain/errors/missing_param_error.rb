# frozen_string_literal: true

class MissingParamError < StandardError
  def initialize(attribute)
    super("#{attribute.capitalize} is required")
    @name = 'MissingParamError'
  end
end
