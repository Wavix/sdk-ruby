# frozen_string_literal: true

describe WavixApi::V2::Messages::SenderIds::Search, type: :service do
  subject(:call) { described_class.call }

  include_context 'with creds'

  let(:path) { 'v2/messages/sender-ids' }

  context 'without params' do
    before do
      stub_request(:get, path_with_creds).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end
end
