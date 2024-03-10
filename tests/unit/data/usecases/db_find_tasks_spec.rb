# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_find_tasks'
require_relative '../../../../src/data/contracts/db/task_repository'
require_relative '../../../../src/core/models/task'

describe DbFindTasks, type: :unit do
  let(:task_repository) { TaskRepositoryStub.new }
  let(:usecase) { described_class.new(task_repository) }

  class TaskRepositoryStub
    include TaskRepository

    def find
      task1 = Task.new('Title 1', 'Description 1')
      task1.mark_as_completed
      task2 = Task.new('Title 2', 'Description 2')
      [task1, task2]
    end
  end

  it 'Should return a list of tasks' do
    sut = usecase.execute
    expect(sut[0][:id]).to be_a(String)
    expect(sut[0][:title]).to eq('Title 1')
    expect(sut[0][:description]).to eq('Description 1')
    expect(sut[0][:completed]).to be(true)
    expect(sut[1][:id]).to be_a(String)
    expect(sut[1][:title]).to eq('Title 2')
    expect(sut[1][:description]).to eq('Description 2')
    expect(sut[1][:completed]).to be(false)
  end

  it 'Should return empty tasks' do
    allow(task_repository).to receive(:find).and_return([])
    sut = usecase.execute
    expect(sut.length).to be(0)
  end

  it 'Should throw if TaskRepository throws' do
    allow(task_repository).to receive(:find).and_raise(StandardError)
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
