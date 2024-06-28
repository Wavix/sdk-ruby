# frozen_string_literal: true

describe WavixApi::V1::Billing::Transactions::Search, type: :service do
  subject(:call) { described_class.new(query).call }

  include_context 'with creds'

  let(:query) do
    {
      from_date: from_date,
      to_date: to_date,
      type: t_type,
      payments: any_payments,
      details_contains: details_contains
    }
  end
  let(:formatted_query) { query }
  let(:path) { 'v1/billing/transactions' }
  let(:from_date) { DateTime.parse('2023.01.01') }
  let(:to_date) { DateTime.parse('2024.01.01') }
  let(:t_type) { 42 }
  let(:any_payments) { false }
  let(:details_contains) { 'word' }

  shared_context 'when succeed' do
    before do
      stub_request(:get, path_with_creds).with(query: formatted_query).to_return(status: 200)
    end

    it { expect(call).to eq(response_with(status: 200, is_succeed: true)) }
  end

  context 'without query' do
    let(:query) { {} }
    let(:error) do
      "The property '#/' did not contain a required property of 'from_date'"
    end

    it_behaves_like 'with error'
  end

  context 'when all valid' do
    let(:formatted_query) do
      query.merge(from_date: from_date.strftime('%Y-%m-%d'), to_date: to_date.strftime('%Y-%m-%d'))
    end

    it_behaves_like 'when succeed'
  end

  shared_context 'when date invalid' do |field|
    context "when #{field} invalid" do
      let(field) { 'invalid' }

      it_behaves_like 'when invalid date format', field
    end

    context "when #{field} in invalid format" do
      let(field) { '01.01.2020' }

      it_behaves_like 'when invalid date format', field
    end
  end

  context 'when from_date invalid' do
    it_behaves_like 'when date invalid', 'from_date'
  end

  context 'when to_date invalid' do
    it_behaves_like 'when date invalid', 'to_date'
  end
end
