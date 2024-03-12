# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_destroy_task'
require_relative '../../../../src/data/contracts/db/task_repository'
require_relative '../../../../src/core/models/task'

describe DbDestroyTask, type: :unit do
  let(:task_repository) do
    class DestroyTaskRepositoryStub
      include TaskRepository

      attr_accessor :tasks

      def initialize
        @tasks = [
          Task.new('Title 1', 'Description 1'),
          Task.new('Title 2', 'Description 2')
        ]
      end

      def destroy(id)
        data = @tasks.find { |t| t.id == id }
        return unless data

        @tasks.delete(data)
        data
      end
    end

    DestroyTaskRepositoryStub.new
  end

  let(:usecase) { described_class.new(task_repository) }

  it 'Should destroy a task' do
    task1 = task_repository.tasks.first
    sut = usecase.execute(task1.id)
    expect(sut[:id]).to eq(task1.id)
    expect(sut[:title]).to eq('Title 1')
    expect(sut[:description]).to eq('Description 1')
    expect(sut[:completed]).to be(false)
    task2 = task_repository.tasks.last
    sut = usecase.execute(task2.id)
    expect(sut[:id]).to eq(task2.id)
    expect(sut[:title]).to eq('Title 2')
    expect(sut[:description]).to eq('Description 2')
    expect(sut[:completed]).to be(false)
  end

  it 'Should throw if TaskRepository throws' do
    allow(task_repository).to receive(:destroy).and_raise(StandardError)
    expect { usecase.execute('any_id') }.to raise_error(StandardError)
  end
end
