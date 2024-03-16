# frozen_string_literal: true

require_relative '../../src/presentation/errors/missing_param_error'
require_relative '../../src/presentation/errors/missing_value_error'
require_relative '../../src/presentation/contracts/validation'

class RequiredFieldValidation
  include Validation

  attr_reader :field_name

  def initialize(field_name)
    @field_name = field_name
  end

  def validate(input)
    return MissingParamError.new(@field_name) if input.empty?
    return MissingValueError.new(@field_name) if input[@field_name] == ''
    return if input[@field_name]

    MissingParamError.new(@field_name)
  end
end
