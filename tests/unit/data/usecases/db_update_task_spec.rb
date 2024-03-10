# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_update_task'
require_relative '../../../../src/data/contracts/db/task_repository'
require_relative '../../../../src/core/models/task'

describe DbUpdateTask, type: :unit do
  let(:task_repository) { TaskRepositoryStub.new }
  let(:usecase) { described_class.new(task_repository) }

  class TaskRepositoryStub
    include TaskRepository

    def tasks
      @tasks ||= [
        Task.new('Title 1', 'Description 1'),
        Task.new('Title 2', 'Description 2')
      ]
    end

    def update(id, updated_task)
      data = tasks.find { |t| t.id == id }
      return unless data

      task = Task.new(updated_task.title, updated_task.description)
      task.mark_as_completed if updated_task.completed
      task_index = tasks.index(data)
      tasks[task_index] = task
      task
    end
  end

  it 'Should update a task' do
    updated_task = Task.new('Title 1 Updated', 'Description 1 Updated')
    updated_task.mark_as_completed
    sut = usecase.execute(task_repository.tasks.first.id, updated_task)
    expect(sut[:id]).to be_a(String)
    expect(sut[:title]).to eq('Title 1 Updated')
    expect(sut[:description]).to eq('Description 1 Updated')
    expect(sut[:completed]).to be(true)
  end

  it 'Should throw if TaskRepository throws' do
    allow(task_repository).to receive(:update).and_raise(StandardError)
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
