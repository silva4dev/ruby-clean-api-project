# frozen_string_literal: true

require_relative '../../../../src/data/usecases/db_find_by_id_task'
require_relative '../../../../src/data/contracts/db/task_repository'
require_relative '../../../../src/core/models/task'

describe DbFindByIdTask, type: :unit do
  let(:task_repository) { TaskRepositoryStub.new }
  let(:usecase) { described_class.new(task_repository) }

  class TaskRepositoryStub
    include TaskRepository

    def task
      @task ||= Task.new('Title 1', 'Description 1')
    end

    def find_by_id(id)
      return unless task.id == id

      task
    end
  end

  it 'Should return a task when filtered by id' do
    sut = usecase.execute(task_repository.task.id)
    expect(sut[:id]).to be_a(String)
    expect(sut[:title]).to eq('Title 1')
    expect(sut[:description]).to eq('Description 1')
    expect(sut[:completed]).to be(false)
  end
end
