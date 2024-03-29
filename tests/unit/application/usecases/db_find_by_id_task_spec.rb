# frozen_string_literal: true

require_relative '../../../../src/application/usecases/db_find_by_id_task'
require_relative '../../../../src/application/contracts/db/task_repository'
require_relative '../../../../src/domain/models/task'

RSpec.describe DbFindByIdTask, type: :unit do
  let(:task_repository) do
    class FindByIdTaskRepositoryStub
      include TaskRepository

      attr_accessor :task

      def initialize
        @task = Task.new('Title 1', 'Description 1')
      end

      def find_by_id(id)
        return unless @task.id == id

        @task
      end
    end

    FindByIdTaskRepositoryStub.new
  end

  let(:usecase) { described_class.new(task_repository) }

  it 'returns a task when filtered by id' do
    sut = usecase.execute({ id: task_repository.task.id })
    expect(sut[:id]).to be_a(String)
    expect(sut[:title]).to eq('Title 1')
    expect(sut[:description]).to eq('Description 1')
    expect(sut[:completed]).to be(false)
  end

  it 'throws an error if TaskRepository throws' do
    allow(task_repository).to receive(:find_by_id).and_raise(StandardError)
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
