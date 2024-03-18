# frozen_string_literal: true

class RequestTypeError < StandardError
  def initialize(param_name, type)
    super("#{param_name.capitalize} must be of type #{type}")
    @name = 'RequestTypeError'
  end
end
