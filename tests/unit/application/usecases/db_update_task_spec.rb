# frozen_string_literal: true

require_relative '../../../../src/application/usecases/db_update_task'
require_relative '../../../../src/application/contracts/db/task_repository'
require_relative '../../../../src/domain/models/task'

RSpec.describe DbUpdateTask, type: :unit do
  let(:task_repository) do
    class UpdateTaskRepositoryStub
      include TaskRepository

      attr_accessor :tasks

      def initialize
        @tasks = [
          Task.new('Title 1', 'Description 1'),
          Task.new('Title 2', 'Description 2')
        ]
      end

      def find_by_id(id)
        @tasks.find { |t| t.id == id }
      end

      def update(id, updated_task)
        task = Task.new(updated_task.title, updated_task.description)
        task.mark_as_completed if updated_task.completed
        @tasks.each_with_index do |t, i|
          if t.id == id
            @tasks[i] = task
            break
          end
        end
        task
      end
    end

    UpdateTaskRepositoryStub.new
  end

  let(:usecase) { described_class.new(task_repository) }

  it 'updates a task' do
    updated_task = Task.new('Title 1 Updated', 'Description 1 Updated')
    updated_task.mark_as_completed
    sut = usecase.execute(
      {
        id: task_repository.tasks.first.id,
        title: updated_task.title,
        description: updated_task.description,
        completed: updated_task.completed
      }
    )
    expect(sut[:id]).to be_a(String)
    expect(sut[:title]).to eq('Title 1 Updated')
    expect(sut[:description]).to eq('Description 1 Updated')
    expect(sut[:completed]).to be(true)
  end

  it 'throws an error if TaskRepository throws' do
    allow(task_repository).to receive(:update).and_raise(StandardError)
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
