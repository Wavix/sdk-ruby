# frozen_string_literal: true

describe WavixApi::V1::Call::Recordings::MonthStatistics::Search, type: :service do
  subject(:call) { described_class.new(params).call }

  include_context 'with creds'

  let(:path) { 'v1/recording/month-statistics' }
  let(:params) { { 'year' => year, 'month' => month } }
  let(:year) { 12 }
  let(:month) { 12 }

  shared_context 'when succeed' do
    before do
      stub_request(:get, path_with_creds).with(query: params).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without params' do
    let(:params) { {} }

    it_behaves_like 'when succeed'
  end

  context 'with params' do
    context 'when all valid' do
      it_behaves_like 'when succeed'
    end

    context 'when nil at year' do
      let(:year) { nil }
      let(:error) do
        "The property '#/year' " \
        'of type null did not match the following type: integer'
      end

      it_behaves_like 'with error'
    end

    context 'when nil at month' do
      let(:month) { nil }
      let(:error) do
        "The property '#/month' of type null did not match the following type: integer"
      end

      it_behaves_like 'with error'
    end

    context 'when invalid at month' do
      let(:month) { 'invalid' }
      let(:error) do
        "The property '#/month' of type string did not match the following type: integer"
      end

      it_behaves_like 'with error'
    end

    context 'when invalid at year' do
      let(:year) { 'invalid' }
      let(:error) do
        "The property '#/year' " \
        'of type string did not match the following type: integer'
      end

      it_behaves_like 'with error'
    end
  end
end
