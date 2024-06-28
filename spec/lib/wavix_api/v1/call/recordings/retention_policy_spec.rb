# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::RetentionPolicy, type: :service do
  let(:path) { 'v1/recordings/retention-policy' }

  it_behaves_like 'when without query and body'
end
