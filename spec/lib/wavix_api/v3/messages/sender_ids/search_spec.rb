# frozen_string_literal: true

describe WavixApi::V3::Messages::SenderIds::Search, type: :service do
  let(:path) { 'v3/messages/sender-ids' }

  it_behaves_like 'when without query and body'
end
