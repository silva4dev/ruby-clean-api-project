# frozen_string_literal: true

require_relative '../../../../src/domain/models/task'
require_relative '../../../../src/domain/errors/invalid_type_error'
require_relative '../../../../src/domain/errors/missing_param_error'

RSpec.describe Task, type: :unit do
  it 'throws error when title is empty' do
    expect { described_class.new('', 'Description') }.to raise_error(MissingParamError)
  end

  it 'throws error when description is empty' do
    expect { described_class.new('Title', '') }.to raise_error(MissingParamError)
  end

  it 'throws error when title is not a string' do
    expect { described_class.new(123, 'Description') }.to raise_error(InvalidTypeError)
  end

  it 'throws error when description is not a string' do
    expect { described_class.new('Title', 123) }.to raise_error(InvalidTypeError)
  end

  it 'marks as completed' do
    task = described_class.new('Title', 'Description')
    task.mark_as_completed
    expect(task.completed).to be true
  end
end
