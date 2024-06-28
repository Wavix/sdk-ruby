# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::UpdateRetentionPolicy, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/recordings/retention-policy' }
  let(:params) do
    {
      'settings' => { 'recording_store_months' => recording_store_months }
    }
  end

  shared_context 'when succeed' do
    before do
      stub_request(:patch, path_with_creds).with(body: params.to_json).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'settings'"
    end

    it_behaves_like 'with error'
  end

  context 'with params' do
    field = '#/settings/recording_store_months'

    context 'when nil argument value' do
      let(:recording_store_months) { nil }

      it_behaves_like 'when did not match type integer', field, 'null'
    end

    context 'when invalid argument value' do
      let(:recording_store_months) { 'invalid' }

      it_behaves_like 'when did not match type integer', field, 'string'
    end

    context 'when valid argument value' do
      let(:recording_store_months) { 12 }

      it_behaves_like 'when succeed'
    end
  end
end
