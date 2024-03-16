# frozen_string_literal: true

require_relative '../../../validation/missing_value_field_validation'
require_relative '../../../validation/validation_composite'

class UpdateTaskValidationFactory
  def self.create
    validations = []
    %i[title description].each do |field|
      validations.push(MissingValueFieldValidation.new(field))
    end
    ValidationComposite.new(validations)
  end
end
