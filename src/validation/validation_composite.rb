# frozen_string_literal: true

require_relative '../../src/presentation/contracts/validation'

class ValidationComposite
  include Validation

  def initialize(validations)
    @validations = validations
  end

  def validate(input)
    @validations.each do |validation|
      error = validation.validate(input)
      return error if error
    end
    nil
  end
end
