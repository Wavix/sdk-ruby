# frozen_string_literal: true

describe WavixApi::V3::Messages::SenderIds::Create, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v3/messages/sender-ids' }
  let(:valid_params) do
    {
      type: 'alphanumeric',
      sender_id: 'sdktst1',
      countries: ['AW'],
      usecase: 'promo',
      samples: ['aaaaa'],
      monthly_volume: '1-1000'

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
    it_behaves_like 'when missing field in params', :usecase
    it_behaves_like 'when missing field in params', :samples

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

    context 'when countries have invalid format' do
      let(:params) { valid_params.merge(countries: 1234) }

      it_behaves_like 'when did not match format', '#/countries', 'integer', 'array'
    end

    context 'when samples have invalid format' do
      let(:params) { valid_params.merge(samples: 1234) }

      it_behaves_like 'when did not match format', '#/samples', 'integer', 'array'
    end

    context 'when usecase has invalid format' do
      let(:params) { valid_params.merge(usecase: 'test') }

      let(:error) do
        "The property '#/usecase' value \"test\" did not match one of the following values: " \
          'transactional, promo, authentication'
      end

      it_behaves_like 'with error'
    end

    context 'when monthly_volume has invalid format' do
      let(:params) { valid_params.merge(monthly_volume: 'test') }
      let(:error) do
        "The property '#/monthly_volume' value \"test\" did not match "\
          'one of the following values: ' \
          '1-1000, 1001-20000, 20001-50000, 50001-100000, More than 100000'
      end

      it_behaves_like 'with error'
    end
  end
end
