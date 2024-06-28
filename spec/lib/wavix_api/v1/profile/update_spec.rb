# frozen_string_literal: true

describe WavixApi::V1::Profile::Update, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/profile' }
  let(:params) do
    {
      timezone: 'UTC',
      contact_email: 'email@gmail.com',
      additional_info: 'dev',
      attn_contact_name: 'wavix',
      billing_address: 'wavix in the house',
      company_name: 'wavix',
      first_name: 'Some',
      last_name: 'Name',
      phone: phone
    }
  end
  let(:phone) { '79231234567' }

  shared_context 'when succeed' do
    before do
      stub_request(:patch, path_with_creds).with(body: params.to_json).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:params) { {} }

    it_behaves_like 'when required field missing', 'additional_info'
  end

  context 'with params' do
    context 'when nil argument value' do
      let(:phone) { nil }

      it_behaves_like 'when did not match type string', '#/phone', 'null'
    end

    context 'when invalid argument value' do
      let(:phone) { 1234 }

      it_behaves_like 'when did not match type string', '#/phone', 'integer'
    end

    context 'when valid argument value' do
      it_behaves_like 'when succeed'
    end
  end
end
