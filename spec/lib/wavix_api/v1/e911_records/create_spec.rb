# frozen_string_literal: true

describe WavixApi::V1::E911Records::Create, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/e911-records' }
  let(:valid_params) do
    {
      name: 'Test ruby sdk',
      phone_number: '18446942889',
      address: {
        street_number: '550',
        street: 'W Adams St',
        location: '2 floor',
        city: 'Chicago',
        state: 'Il',
        zip_code: '60661',
        zip_plus_four: '112'
      }
    }
  end
  let(:params) { valid_params }

  shared_context 'when succeed' do
    before do
      stub_request(:post, path_with_creds).with(body: params.to_json).to_return(status: 200)
      call
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:params) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'name'"
    end

    it_behaves_like 'with error'
  end

  context 'with params' do
    shared_context 'when missing field in params' do |field|
      let(:params) { valid_params.except(field) }

      it_behaves_like 'when required field missing', field
    end

    shared_context 'when invalid format' do |field|
      let(:params) { valid_params.merge(field => 1234) }

      it_behaves_like 'when did not match type string', "#/#{field}", 'integer'
    end

    it_behaves_like 'when succeed'
    it_behaves_like 'when missing field in params', :name
    it_behaves_like 'when invalid format', :name
    it_behaves_like 'when missing field in params', :phone_number
    it_behaves_like 'when invalid format', :phone_number
    it_behaves_like 'when missing field in params', :address

    context 'when address invalid format' do |_field|
      let(:params) { valid_params.merge(address: 1234) }

      it_behaves_like 'when did not match format', '#/address', 'integer', 'object'
    end
  end
end
