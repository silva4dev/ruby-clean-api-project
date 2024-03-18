# frozen_string_literal: true

class RequestParamError < StandardError
  def initialize(param_name)
    super("#{param_name.capitalize} is required")
    @name = 'RequestParamError'
  end
end
