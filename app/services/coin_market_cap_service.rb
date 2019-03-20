class CoinMarketCapService
  class RequestError < RuntimeError; end

  LATEST_URL = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'

  def self.call
    response = HTTParty.get(
      LATEST_URL,
      headers: { 'X-CMC_PRO_API_KEY' => Rails.application.credentials.coin_market_cap_api_key }
    )

    if response.code != 200
      raise RequestError("Response code was #{response.code}")
    end

    data = JSON.parse(response.body)['data']

    data.each do |currency_data|
      c = Currency.where(symbol: currency_data['symbol']).first_or_initialize

      c.name = currency_data['name']
      c.price_in_usd = currency_data['quote']['USD']['price']

      c.save!
    end
  end
end