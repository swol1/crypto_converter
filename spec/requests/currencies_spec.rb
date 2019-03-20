require 'rails_helper'

RSpec.describe "Currencies", type: :request do
  before do
    @currency_1 = Currency.create!(name: 'Bitcoin', symbol: 'BTC', price_in_usd: '3500')
    @currency_2 = Currency.create!(name: 'Etherium', symbol: 'ETH', price_in_usd: '1000')
  end

  describe "GET /currencies" do
    it "returns an array of symbols for cryptocurrencies" do
      get currencies_path
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)

      expect(json).to match_array(['BTC', 'ETH'])
    end
  end
end
