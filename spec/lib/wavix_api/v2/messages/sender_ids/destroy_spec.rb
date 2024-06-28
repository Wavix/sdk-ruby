# frozen_string_literal: true

describe WavixApi::V2::Messages::SenderIds::Destroy, type: :service do
  it_behaves_like 'when deleting record', 'v2/messages/sender-ids', true
end
