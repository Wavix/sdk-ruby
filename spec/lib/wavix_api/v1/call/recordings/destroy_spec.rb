# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::Destroy, type: :service do
  it_behaves_like 'when deleting record', 'v1/recordings'
end
