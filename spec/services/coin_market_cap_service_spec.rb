require_relative '../rails_helper'

RSpec.describe CoinMarketCapService do
  it 'saves cryptocurrencies' do
    expect { CoinMarketCapService.call }.to \
      change { Currency.count }.by(100)
  end
end