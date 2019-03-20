require 'rails_helper'

RSpec.describe CoinMarketCapService do
  it 'saves cryptocurrencies' do
    VCR.use_cassette("coin_market_cap/list_all_twice") do
      expect { CoinMarketCapService.call }.to \
      change { Currency.count }.by(100)

      expect { CoinMarketCapService.call }.to \
      change { Currency.count }.by(0)

      btc = Currency.where(symbol: 'BTC', name: 'Bitcoin').first

      expect(btc.price_in_usd.to_s).to eq '4068.39'
    end
  end
end