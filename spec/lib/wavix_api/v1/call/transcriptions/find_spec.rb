# frozen_string_literal: true

describe WavixApi::V1::Call::Transcriptions::Find, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:cdr_id) { 'uuid' }
  let(:path) { "v1/cdr/#{cdr_id}/transcription" }
  let(:params) { { 'cdr_id' => cdr_id } }

  context 'when id is null' do
    let(:cdr_id) { nil }
    let(:error) { "The property '#/cdr_id' of type null did not match the following type: string" }

    it_behaves_like 'with error'
  end

  context 'when response 200' do
    before do
      stub_request(:get, path_with_creds).with(query: params).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'when response 400' do
    let(:expected_response) do
      response_with(
        status: 400,
        is_succeed: false,
        body: { 'error' => 'Bad request' }
      )
    end

    before do
      stub_request(:get, path_with_creds).with(query: params).to_return(
        status: 400,
        body: { error: 'Bad request' }.to_json
      )
    end

    it { expect(call).to eq(expected_response) }
  end
end
