# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_add_task'
require_relative '../../../../src/data/contracts/db/task_repository'
require_relative '../../../../src/core/models/task'

describe DbAddTask, type: :unit do
  let(:task_repository) { TaskRepositoryStub.new }
  let(:usecase) { described_class.new(task_repository) }

  class TaskRepositoryStub
    include TaskRepository

    def add(task)
      task
    end
  end

  it 'Should add a task' do
    sut = usecase.execute(Task.new('Title 1', 'Description 1'))
    expect(sut[:id]).to be_a(String)
    expect(sut[:title]).to eq('Title 1')
    expect(sut[:description]).to eq('Description 1')
    expect(sut[:completed]).to be(false)
  end

  it 'Should throw if TaskRepository throws' do
    allow(task_repository).to receive(:add).and_raise(StandardError)
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
