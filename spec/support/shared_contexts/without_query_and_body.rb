# frozen_string_literal: true

shared_context 'when without query and body' do
  subject(:call) { described_class.call }

  include_context 'with creds'

  context 'when response 200' do
    before do
      stub_request(:get, path_with_creds).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'when response 400' do
    let(:expected_response) do
      response_with(
        status: 400,
        is_succeed: false,
        body: { 'error' => true }
      )
    end

    before do
      stub_request(:get, path_with_creds).to_return(status: 400, body: { error: true }.to_json)
    end

    it { expect(call).to eq(expected_response) }
  end
end
