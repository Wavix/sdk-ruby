# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::UpdateRecordingSettings, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/recordings/recording-settings' }
  let(:new_state) { true }
  let(:dids) { [] }
  let(:sip_trunks) { [] }

  context 'without params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'recording'"
    end

    it_behaves_like 'with error'
  end

  shared_context 'when succeed' do
    before do
      stub_request(:put, path_with_creds).with(body: params.to_json).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  shared_context 'when dids are invalid' do
    context 'when dids with string' do
      let(:dids) { %w[123 invalid] }

      it_behaves_like 'when invalid digits format', '#/recording/dids/1', 'invalid'
    end

    context 'when dids with nil' do
      let(:dids) { [nil, '123'] }
      let(:error) do
        "The property '#/recording/dids/0' of type null did not match the following type: string"
      end

      it_behaves_like 'with error'
    end
  end

  shared_context 'when sip_trunks are invalid' do
    let(:sip_trunks) { ['name', nil] }
    let(:error) do
      "The property '#/recording/sip_trunks/1' " \
      'of type null did not match the following type: string'
    end

    it_behaves_like 'with error'
  end

  shared_context 'when new_state is invalid' do
    context 'when new_state is nil' do
      let(:new_state) { nil }
      let(:error) do
        "The property '#/recording/new_state' " \
        'of type null did not match the following type: boolean'
      end

      it_behaves_like 'with error'
    end

    context 'when new_state is string' do
      let(:new_state) { 'false' }
      let(:error) do
        "The property '#/recording/new_state' " \
        'of type string did not match the following type: boolean'
      end

      it_behaves_like 'with error'
    end
  end

  context 'with body' do
    context 'with dids and new_state only' do
      let(:params) do
        {
          'recording' => { 'dids' => dids, 'new_state' => new_state }
        }
      end

      it_behaves_like 'when dids are invalid'
      it_behaves_like 'when new_state is invalid'

      context 'when dids are valid' do
        let(:dids) { %w[1234 5678] }

        it_behaves_like 'when succeed'
      end
    end

    context 'with sip_trunks and new_state only' do
      let(:params) do
        {
          'recording' => { 'sip_trunks' => sip_trunks, 'new_state' => new_state }
        }
      end

      it_behaves_like 'when sip_trunks are invalid'
      it_behaves_like 'when new_state is invalid'

      context 'when sip_trunks are valid' do
        let(:sip_trunks) { %w[1234 name] }

        it_behaves_like 'when succeed'
      end
    end

    context 'with all keys' do
      let(:params) do
        {
          'recording' => { 'dids' => dids, 'sip_trunks' => sip_trunks, 'new_state' => new_state }
        }
      end

      context 'when sip_trunks are invalid' do
        let(:dids) { [] }

        it_behaves_like 'when sip_trunks are invalid'
      end

      context 'when dids are invalid' do
        let(:sip_trunks) { [] }

        it_behaves_like 'when dids are invalid'
      end

      context 'when all valid' do
        let(:dids) { ['1234'] }
        let(:sip_trunks) { ['name'] }
        let(:error) { '' }

        it_behaves_like 'when succeed'
      end
    end
  end
end
