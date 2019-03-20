require 'rails_helper'

RSpec.describe "Conversions", type: :request do
  describe "POST /conversions" do
    before do
      @btc = Currency.create!(name: 'Bitcoin', symbol: 'BTC', price_in_usd: '3500')
      @eth = Currency.create!(name: 'Etherium', symbol: 'ETH', price_in_usd: '350')
    end

    it "creates conversion" do
      post conversions_path, params: {
        from_currency_symbol: 'BTC',
        to_currency_symbol: 'ETH',
        amount: '1'
      }

      expect(response).to have_http_status(200)

      conversion = Conversion.where(from_currency: @btc, to_currency: @eth).first

      expect(conversion.amount.to_s).to eq '1.0'
      expect(conversion.from_currency_price_in_usd.to_s).to eq '3500.0'
      expect(conversion.to_currency_price_in_usd.to_s).to eq '350.0'

      json = JSON.parse(response.body)
      expect(json['amount_gained']).to eq '10.0'
    end
  end
end
