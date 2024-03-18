# frozen_string_literal: true

require_relative '../../../../src/presentation/controllers/destroy_task_controller'
require_relative '../../../../src/domain/usecases/destroy_task'

describe DestroyTaskController, type: :unit do
  let(:usecase) do
    class DestroyTaskUseCaseStub
      include DestroyTask

      def execute(input)
        {
          id: 1,
          title: 'New title',
          description: 'New description',
          completed: false
        }
      end
    end
    DestroyTaskUseCaseStub.new
  end
  let(:controller) { described_class.new(usecase) }

  it 'Should return 204 if valid data is provided' do
    http_request = {
      params: {
        id: 1
      }
    }
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(204)
    expect(sut[:body]).to be_nil
  end

  it 'Should return 404 if invalid data is provided' do
    allow(usecase).to receive(:execute).and_return(nil)
    http_request = {
      params: {
        id: 'non_existent_id'
      }
    }
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(404)
    expect(sut[:body]).to eq(NotFoundError.new)
  end
end
