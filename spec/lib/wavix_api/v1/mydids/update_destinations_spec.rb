# frozen_string_literal: true

describe WavixApi::V1::Mydids::UpdateDestinations, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/mydids/update-destinations' }
  let(:valid_params) do
    {
      dids: '48616101971',
      sms_relay_url: 'http://api.wavix.dev',
      destinations: [
        {
          destination: '56947',
          priority: 1,
          transport: 5,
          trunk_id: 144
        }
      ]
    }
  end
  let(:params) { valid_params }

  shared_context 'when succeed' do
    before do
      stub_request(:post, path_with_creds).with(body: params.to_json).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:params) { {} }
    let(:error) { 'Either dids or ids is required' }

    it_behaves_like 'with error'
  end

  context 'with params' do
    shared_context 'when invalid type' do |field, value, type, expected_type|
      let(:params) { valid_params.merge(field => value) }

      it_behaves_like 'when did not match format', "#/#{field}", type, expected_type
    end

    context 'when ids is invalid' do
      let(:params) { valid_params.merge(ids: 'invalid') }
      let(:error) do
        "The property '#/ids' of type string did not match one or more of the required schemas"
      end

      it_behaves_like 'with error'
    end

    context 'when without dids and ids' do
      let(:params) { valid_params.except(:dids) }
      let(:error) { 'Either dids or ids is required' }

      it_behaves_like 'with error'
    end

    it_behaves_like 'when invalid type', :sms_relay_url, 111, 'integer', 'string'
    it_behaves_like 'when invalid type', :destinations, 'invalid', 'string', 'array'

    context 'when valid with dids' do
      it_behaves_like 'when succeed'
    end

    context 'when with both ids and dids' do
      let(:params) { valid_params.merge(ids: '123') }
      let(:error) { 'Either dids or ids is supported' }

      it_behaves_like 'with error'
    end

    context 'when without destinations and sms_relay_url' do
      let(:params) { valid_params.except(:destinations, :sms_relay_url) }
      let(:error) { "Either 'destinations' or 'sms_relay_url' or both must be specified" }

      it_behaves_like 'with error'
    end

    context 'when valid with ids' do
      let(:params) do
        {
          ids: '123,321',
          sms_relay_url: 'http://api.wavix.dev',
          destinations: [
            {
              destination: '56947',
              priority: 1,
              transport: 5,
              trunk_id: 144
            }
          ]
        }
      end

      it_behaves_like 'when succeed'
    end
  end
end
