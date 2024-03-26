# frozen_string_literal: true

require_relative '../../../../src/domain/builders/task_builder'

RSpec.describe TaskBuilder, type: :unit do
  let(:task_builder) { described_class.new }

  it 'builds a task' do
    task = task_builder
        .with_title('New title')
        .with_description('New description')
        .with_completed(true)
        .build
    expect(task).to be_an_instance_of(Task)
    expect(task.title).to eq('New title')
    expect(task.description).to eq('New description')
    expect(task.completed).to be(true)
  end
end
