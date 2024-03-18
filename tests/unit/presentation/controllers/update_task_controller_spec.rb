# frozen_string_literal: true

require_relative '../../../../src/presentation/controllers/update_task_controller'
require_relative '../../../../src/domain/usecases/update_task'
require_relative '../../../../src/presentation/contracts/validation'

describe UpdateTaskController, type: :unit do
  let(:usecase) do
    class UpdateTaskUseCaseStub
      include UpdateTask

      def execute(input)
        {
          id: 1,
          title: 'Updated title',
          description: 'Updated description',
          completed: true
        }
      end
    end
    UpdateTaskUseCaseStub.new
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
      params: {
        id: 1
      },
      body: {
        title: 'Updated title',
        description: 'Updated description',
        completed: true
      }
    }
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(204)
    expect(sut[:body]).to be_nil
  end

  it 'Should return 404 if task does not exist' do
    allow(usecase).to receive(:execute).and_return(nil)
    http_request = {
      params: {
        id: 'non_existent_id'
      },
      body: {
        title: 'Updated title',
        description: 'Updated description',
        completed: true
      }
    }
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(404)
    expect(sut[:body]).to eq(NotFoundError.new)
  end

  it 'Should return 400 if passing empty body' do
    allow(validation).to receive(:validate).and_return(
      {
        errors: [
          RequestParamError.new(:title),
          RequestParamError.new(:description)
        ]
      }
    )
    http_request = { body: {} }
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(400)
    errors = sut[:body][:errors].map { |error| { error: error.message } }
    expect(errors).to contain_exactly({ error: 'Title is required' }, { error: 'Description is required' })
  end
end
