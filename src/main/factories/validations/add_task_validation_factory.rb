# frozen_string_literal: true

require_relative '../../../validation/required_field_validation'
require_relative '../../../validation/validation_composite'

class AddTaskValidationFactory
  def self.create
    validations = []
    %i[title description].each do |field|
      validations.push(RequiredFieldValidation.new(field))
    end
    ValidationComposite.new(validations)
  end
end
