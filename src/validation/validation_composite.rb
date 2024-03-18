# frozen_string_literal: true

require_relative '../../src/presentation/contracts/validation'

class ValidationComposite
  include Validation

  def initialize(validations)
    @validations = validations
  end

  def validate(input)
    errors = []

    @validations.each do |validation|
      error = validation.validate(input)
      errors.push(error) if error
    end

    return unless errors.length.positive?

    errors.length == 1 ? errors.first : errors
  end
end
