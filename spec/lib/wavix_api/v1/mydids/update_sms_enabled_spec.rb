# frozen_string_literal: true

describe WavixApi::V1::Mydids::UpdateSmsEnabled, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/mydids/update-sms-enabled' }
  let(:id) { 1 }
  let(:valid_params) do
    {
      id: id, sms_enabled: true
    }
  end
  let(:params) { valid_params }

  shared_context 'when succeed' do
    before do
      stub_request(
        :put,
        path_with_creds
      ).with(body: params.except(:id).to_json).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  shared_context 'without required field' do |field|
    let(:params) { valid_params.except(field) }

    it_behaves_like 'when required field missing', field
  end

  context 'without params' do
    let(:params) { {} }

    it_behaves_like 'without required field', :sms_enabled
  end

  context 'with params' do
    it_behaves_like 'without required field', :sms_enabled
    it_behaves_like 'without required field', :id

    shared_context 'when invalid type' do |field, value, type, expected_type|
      let(:params) { valid_params.merge(field => value) }

      it_behaves_like 'when did not match format', "#/#{field}", type, expected_type
    end

    it_behaves_like 'when invalid type', :sms_enabled, 111, 'integer', 'boolean'
    it_behaves_like 'when invalid type', :id, 'invalid', 'string', 'integer'

    context 'when all valid' do
      it_behaves_like 'when succeed'
    end
  end
end
