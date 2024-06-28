# frozen_string_literal: true

describe WavixApi::V1::Cdrs::Metrics, type: :service do
  subject(:call) { described_class.new(query).call }

  include_context 'with creds'

  let(:path) { 'v1/cdr/metrics' }
  let(:query) do
    {
      from: from,
      to: to
    }
  end
  let(:from) { DateTime.parse('2023-01-01') }
  let(:to) { DateTime.parse('2024-01-01') }
  let(:formatted_query) { query }

  before do
    stub_request(:get, path_with_creds).with(query: formatted_query).to_return(status: 200)
  end

  shared_examples 'when succeed' do
    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without query' do
    let(:query) { {} }

    it_behaves_like 'when succeed'
  end

  context 'when all valid' do
    let(:formatted_query) do
      query.merge(from: from.strftime('%Y-%m-%d'), to: to.strftime('%Y-%m-%d'))
    end

    it_behaves_like 'when succeed'
  end

  shared_context 'when date invalid' do |field|
    context "when #{field} invalid" do
      let(field) { 'invalid' }

      it_behaves_like 'when invalid date format', field
    end

    context "when #{field} in invalid format" do
      let(field) { '2023.01.01' }

      it_behaves_like 'when invalid date format', field
    end
  end

  context 'when from_date invalid' do
    it_behaves_like 'when date invalid', 'from'
  end

  context 'when to_date invalid' do
    it_behaves_like 'when date invalid', 'to'
  end
end
