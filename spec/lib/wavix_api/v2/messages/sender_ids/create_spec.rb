# frozen_string_literal: true

describe WavixApi::V2::Messages::SenderIds::Create, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v2/messages/sender-ids' }
  let(:valid_params) do
    {
      type: 'alphanumeric',
      sender_id: 'sdktst1',
      countries: ['AW']
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
      "The property '#/' did not contain a required property of 'type'"
    end

    it_behaves_like 'with error'
  end

  context 'with params' do
    shared_context 'when missing field in params' do |field|
      let(:params) { valid_params.except(field) }

      it_behaves_like 'when required field missing', field
    end

    it_behaves_like 'when succeed'
    it_behaves_like 'when missing field in params', :type
    it_behaves_like 'when missing field in params', :sender_id
    it_behaves_like 'when missing field in params', :countries

    context 'when type has invalid format' do
      let(:params) { valid_params.merge(type: 'invalid') }
      let(:error) do
        "The property '#/type' value \"invalid\" did not match one of the following values: " \
        'numeric, alphanumeric'
      end

      it_behaves_like 'with error'
    end

    context 'when sender_id has invalid format' do
      let(:params) { valid_params.merge(sender_id: 1234) }

      it_behaves_like 'when did not match type string', '#/sender_id', 'integer'
    end

    context 'when countries have invalid format' do |_field|
      let(:params) { valid_params.merge(countries: 1234) }

      it_behaves_like 'when did not match format', '#/countries', 'integer', 'array'
    end
  end
end
