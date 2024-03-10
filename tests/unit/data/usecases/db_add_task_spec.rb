# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_add_task'
require_relative '../../../../src/data/contracts/db/task_repository'
require_relative '../../../../src/core/models/task'

describe DbAddTask, type: :unit do
  class TaskRepositoryStub
    include TaskRepository

    def add(task)
      task
    end
  end

  def make_sut
    task_repository = TaskRepositoryStub.new
    { task_repository: }
  end

  it 'Should add a task' do
    sut = make_sut
    usecase = described_class.new(sut[:task_repository])
    output = usecase.execute(Task.new('Title 1', 'Description 1'))
    expect(output[:id]).to be_a(String)
    expect(output[:title]).to eq('Title 1')
    expect(output[:description]).to eq('Description 1')
    expect(output[:completed]).to be(false)
  end

  it 'Should throw if TaskRepository throws' do
    sut = make_sut
    allow(sut[:task_repository]).to receive(:add).and_raise(StandardError)
    usecase = described_class.new(sut[:task_repository])
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
