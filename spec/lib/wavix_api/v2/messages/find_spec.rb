# frozen_string_literal: true

describe WavixApi::V2::Messages::Find, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:uuid) { 'uuiddas' }
  let(:path) { "v2/messages/#{uuid}" }
  let(:params) { { id: uuid } }

  context 'when id is null' do
    let(:uuid) { nil }
    let(:error) { "The property '#/id' of type null did not match the following type: string" }

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
