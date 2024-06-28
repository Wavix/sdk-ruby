# frozen_string_literal: true

shared_context 'when deleting record' do |resource, is_uuid|
  subject(:call) { described_class.call(id) }

  include_context 'with creds'

  let(:id) { is_uuid ? 'uuid' : 1 }
  let(:path) { "#{resource}/#{id}" }

  context 'when id is null' do
    let(:id) { nil }

    it_behaves_like 'when ID is not defined', is_uuid
  end

  context 'when response 200' do
    before do
      stub_request(:delete, path_with_creds).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'when response 404' do
    let(:expected_response) do
      response_with(
        status: 404,
        is_succeed: false,
        body: { 'error' => 'Not Found' }
      )
    end

    before do
      stub_request(:delete, path_with_creds).to_return(
        status: 404,
        body: { error: 'Not Found' }.to_json
      )
    end

    it { expect(call).to eq(expected_response) }
  end
end
