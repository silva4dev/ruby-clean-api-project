# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_find_tasks'
require_relative '../../../../src/data/contracts/db/task_repository'
require_relative '../../../../src/core/models/task'

describe DbFindTasks, type: :unit do
  class TaskRepositoryStub
    include TaskRepository

    def find
      task1 = Task.new('Title 1', 'Description 1')
      task1.mark_as_completed
      task2 = Task.new('Title 2', 'Description 2')
      [task1, task2]
    end
  end

  def make_sut
    task_repository = TaskRepositoryStub.new
    usecase = DbFindTasks.new(task_repository)
    { usecase:, task_repository: }
  end

  it 'Should return a list of tasks' do
    sut = make_sut
    output = sut[:usecase].execute
    expect(output[0][:id]).to be_a(String)
    expect(output[0][:title]).to eq('Title 1')
    expect(output[0][:description]).to eq('Description 1')
    expect(output[0][:completed]).to be(true)
    expect(output[1][:id]).to be_a(String)
    expect(output[1][:title]).to eq('Title 2')
    expect(output[1][:description]).to eq('Description 2')
    expect(output[1][:completed]).to be(false)
  end

  it 'Should return empty tasks' do
    sut = make_sut
    allow(sut[:task_repository]).to receive(:find).and_return([])
    output = sut[:usecase].execute
    expect(output.length).to be(0)
  end

  it 'Should throw if TaskRepository throws' do
    sut = make_sut
    allow(sut[:task_repository]).to receive(:find).and_raise(StandardError)
    expect { sut[:usecase].execute }.to raise_error(StandardError)
  end
end
