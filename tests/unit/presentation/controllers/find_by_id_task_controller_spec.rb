# frozen_string_literal: true

require_relative '../../../../src/presentation/controllers/find_by_id_task_controller'
require_relative '../../../../src/domain/usecases/find_by_id_task'
require_relative '../../../../src/presentation/errors/not_found_error'

describe FindByIdTaskController, type: :unit do
  let(:usecase) do
    class FindByIdTaskUseCaseStub
      include FindByIdTask

      def execute(input)
        {
          id: 1,
          title: 'New title',
          description: 'New description',
          completed: false
        }
      end
    end
    FindByIdTaskUseCaseStub.new
  end
  let(:controller) { described_class.new(usecase) }

  it 'Should return 200 if valid data is provided' do
    http_request = {
      params: {
        id: 1
      }
    }
    sut = controller.handle(http_request)
    expect(sut[:status_code]).to be(200)
    expect(sut[:body][:id]).to be(1)
    expect(sut[:body][:title]).to eq('New title')
    expect(sut[:body][:description]).to eq('New description')
    expect(sut[:body][:completed]).to be(false)
  end

  it 'Should return 404 if task does not exist' do
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
