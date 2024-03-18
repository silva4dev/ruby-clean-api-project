# frozen_string_literal: true

require_relative '../../../../src/presentation/controllers/add_task_controller'
require_relative '../../../../src/domain/usecases/add_task'
require_relative '../../../../src/presentation/contracts/validation'

describe AddTaskController, type: :unit do
  let(:usecase) do
    class AddTaskUseCaseStub
      include AddTask

      def execute(input)
        {
          id: 1,
          title: 'New title',
          description: 'New description',
          completed: false
        }
      end
    end
    AddTaskUseCaseStub.new
  end
  let(:validation) do
    class ValidationCompositeStub
      include Validation

      def validate(input)
        nil
      end
    end
    ValidationCompositeStub.new
  end
  let(:controller) { described_class.new(usecase, validation) }

  it 'Should return 204 if valid data is provided' do
    http_request = {
      body: {
        title: 'New title',
        description: 'New description'
      }
    }
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(204)
    expect(sut[:body]).to be_nil
  end
end
