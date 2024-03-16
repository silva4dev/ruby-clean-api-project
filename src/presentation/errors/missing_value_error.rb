# frozen_string_literal: true

class MissingValueError < StandardError
  def initialize(param_name)
    super("Missing value: #{param_name}")
    @name = 'MissingValueError'
  end
end
