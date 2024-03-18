# frozen_string_literal: true

require_relative '../../../../src/presentation/controllers/find_tasks_controller'
require_relative '../../../../src/domain/usecases/find_tasks'

describe FindTasksController, type: :unit do
  let(:usecase) do
    class FindTasksUseCaseStub
      include FindTasks

      def execute
        [
          {
            id: 1,
            title: 'New title',
            description: 'New description',
            completed: false
          },
          {
            id: 2,
            title: 'Other title',
            description: 'Other description',
            completed: true
          }
        ]
      end
    end
    FindTasksUseCaseStub.new
  end
  let(:controller) { described_class.new(usecase) }

  it 'Should return 200 if valid data is provided' do
    http_request = {}
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(200)
  end
end
