# frozen_string_literal: true

require_relative '../../../validation/missing_value_field_validation'
require_relative '../../../validation/type_field_validation'
require_relative '../../../validation/validation_composite'

class UpdateTaskValidationFactory
  def self.create
    validations = []
    %i[title description completed].each do |field|
      validations.push(MissingValueFieldValidation.new(field))
      validations.push(TypeFieldValidation.new(field, String)) if field == :title
      validations.push(TypeFieldValidation.new(field, String)) if field == :description
    end
    ValidationComposite.new(validations)
  end
end
