# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::MonthStatistics::Details, type: :service do
  subject(:call) { described_class.new(id: id).call }

  include_context 'with creds'

  let(:id) { 1 }
  let(:path) { "v1/recording/month-statistics/#{id}/details" }

  context 'when id is null' do
    let(:id) { nil }

    it_behaves_like 'when ID is not defined'
  end

  context 'when response 200' do
    before do
      stub_request(:get, path_with_creds).to_return(status: 200)
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
      stub_request(:get, path_with_creds).to_return(
        status: 404,
        body: { error: 'Not Found' }.to_json
      )
    end

    it { expect(call).to eq(expected_response) }
  end
end
