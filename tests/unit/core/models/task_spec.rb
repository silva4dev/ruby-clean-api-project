# frozen_string_literal: true

require_relative '../../../../src/core/models/task'

describe Task, type: :unit do
  it 'Should throw error when title is empty' do
    expect { described_class.new('', 'Description') }.to raise_error(MissingValueError, 'Title is required')
  end

  it 'Should throw error when description is empty' do
    expect { described_class.new('Title', '') }.to raise_error(MissingValueError, 'Description is required')
  end

  it 'Should throw error when title is not a string' do
    expect { described_class.new(123, 'Description') }.to raise_error(InvalidTypeError, 'Title must be of type String')
  end

  it 'Should throw error when description is not a string' do
    expect { described_class.new('Title', 123) }.to raise_error(InvalidTypeError, 'Description must be of type String')
  end

  it 'Should mark as completed' do
    task = described_class.new('Title', 'Description')
    task.mark_as_completed
    expect(task.completed).to be true
  end
end
