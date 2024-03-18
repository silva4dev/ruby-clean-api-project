# frozen_string_literal: true

require_relative '../../src/presentation/errors/request_param_error'
require_relative '../../src/presentation/errors/request_value_error'
require_relative '../../src/presentation/contracts/validation'

class RequiredFieldValidation
  include Validation

  attr_reader :field_name

  def initialize(field_name)
    @field_name = field_name
  end

  def validate(input)
    return RequestParamError.new(@field_name) if input.empty?
    return RequestValueError.new(@field_name) if input[@field_name] == ''
    return if input[@field_name]

    RequestParamError.new(@field_name)
  end
end
