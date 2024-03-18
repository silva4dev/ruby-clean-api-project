# frozen_string_literal: true

require_relative '../../src/presentation/errors/request_type_error'
require_relative '../../src/presentation/errors/request_param_error'
require_relative '../../src/presentation/contracts/validation'

class TypeFieldValidation
  include Validation

  attr_reader :field_name, :type

  def initialize(field_name, type)
    @field_name = field_name
    @type = type
  end

  def validate(input)
    return nil if input.empty?
    return unless input[@field_name]

    RequestTypeError.new(@field_name, @type) unless input[@field_name].is_a?(@type)
  end
end
