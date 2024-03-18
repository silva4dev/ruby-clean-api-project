# frozen_string_literal: true

class RequestValueError < StandardError
  def initialize(param_name)
    super("Missing value: #{param_name}")
    @name = 'RequestValueError'
  end
end
