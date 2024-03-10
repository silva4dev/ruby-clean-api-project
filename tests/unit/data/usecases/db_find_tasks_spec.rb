# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_find_tasks'
require_relative '../../../../src/data/contracts/db/task_repository'

class TaskRepositoryStub
  include TaskRepository

  def find
    task1 = Task.new('Title 1', 'Description 1')
    task1.mark_as_completed
    task2 = Task.new('Title 2', 'Description 2')
    [task1, task2]
  end
end

describe DbFindTasks, type: :unit do
  it 'Should return a list of tasks' do
    task_repository = TaskRepositoryStub.new
    usecase = described_class.new(task_repository)
    output = usecase.execute
    expect(output[0][:title]).to be('Title 1')
    expect(output[0][:description]).to be('Description 1')
    expect(output[0][:completed]).to be(true)
    expect(output[1][:title]).to be('Title 2')
    expect(output[1][:description]).to be('Description 2')
    expect(output[1][:completed]).to be(false)
  end

  it 'Should return empty tasks' do
    task_repository = TaskRepositoryStub.new
    allow(task_repository).to receive(:find).and_return([])
    usecase = described_class.new(task_repository)
    output = usecase.execute
    expect(output.length).to be(0)
  end

  it 'Should throw if TaskRepository throws' do
    task_repository = TaskRepositoryStub.new
    allow(task_repository).to receive(:find).and_raise(StandardError)
    usecase = described_class.new(task_repository)
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
