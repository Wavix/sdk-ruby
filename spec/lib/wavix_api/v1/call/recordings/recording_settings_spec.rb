# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::RecordingSettings, type: :service do
  subject(:call) { described_class.new(arguments).call }

  include_context 'with creds'

  let(:path) { 'v1/recordings/recording-settings' }
  let(:dids) { [] }
  let(:sip_trunks) { [] }

  context 'without arguments' do
    let(:arguments) { {} }

    before do
      stub_request(:get, path_with_creds).to_return(status: 400)
    end

    it { expect(call).to eq(response_with(status: 400, is_succeed: false)) }
  end

  shared_context 'when succeed' do
    before do
      stub_request(:get, path_with_creds).with(query: arguments).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  shared_context 'when dids are invalid' do
    context 'when dids with string' do
      let(:dids) { %w[123 invalid] }
      let(:error) do
        'The property \'#/dids/1\' value "invalid" did not match the regex \'(?-mix:^\d+$)\''
      end

      it_behaves_like 'with error'
    end

    context 'when dids with nil' do
      let(:dids) { [nil, '123'] }
      let(:error) do
        "The property '#/dids/0' of type null did not match the following type: string"
      end

      it_behaves_like 'with error'
    end
  end

  shared_context 'when sip_trunks are invalid' do
    let(:sip_trunks) { ['name', nil] }
    let(:error) do
      "The property '#/sip_trunks/1' of type null did not match the following type: string"
    end

    it_behaves_like 'with error'
  end

  context 'with arguments' do
    context 'with dids only' do
      let(:arguments) { { 'dids' => dids } }

      it_behaves_like 'when dids are invalid'

      context 'when dids are valid' do
        let(:dids) { %w[1234 5678] }

        it_behaves_like 'when succeed'
      end
    end

    context 'with sip_trunks only' do
      let(:arguments) { { 'sip_trunks' => sip_trunks } }

      it_behaves_like 'when sip_trunks are invalid'

      context 'when sip_trunks are valid' do
        let(:sip_trunks) { %w[1234 name] }

        it_behaves_like 'when succeed'
      end
    end

    context 'with both' do
      let(:arguments) { { 'dids' => dids, 'sip_trunks' => sip_trunks } }

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
