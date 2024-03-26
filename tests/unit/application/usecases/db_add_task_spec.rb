# frozen_string_literal: true

require_relative '../../../../src/application/usecases/db_add_task'
require_relative '../../../../src/application/contracts/db/task_repository'
require_relative '../../../../src/domain/models/task'

RSpec.describe DbAddTask, type: :unit do
  let(:task_repository) do
    class AddTaskRepositoryStub
      include TaskRepository

      def add(task) = task
    end

    AddTaskRepositoryStub.new
  end

  let(:usecase) { described_class.new(task_repository) }

  it 'adds a task' do
    sut = usecase.execute({ title: 'Title 1', description: 'Description 1' })
    expect(sut[:id]).to be_a(String)
    expect(sut[:title]).to eq('Title 1')
    expect(sut[:description]).to eq('Description 1')
    expect(sut[:completed]).to be(false)
  end

  it 'throws an error if TaskRepository throws' do
    allow(task_repository).to receive(:add).and_raise(StandardError)
    expect { usecase.execute }.to raise_error(StandardError)
  end
end
