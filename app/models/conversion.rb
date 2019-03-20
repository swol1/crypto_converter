class Conversion < ApplicationRecord
  belongs_to :from_currency, class_name: 'Currency'
  belongs_to :to_currency, class_name: 'Currency'

  validates :amount, numericality: { greater_than: 0 }

  before_create :set_currency_prices

  def amount_gained
    result = amount * from_currency_price_in_usd / to_currency_price_in_usd
    result.round(8)
  end

  def as_json(options)
    {
      from_currency_symbol: from_currency.symbol,
      to_currency_symbol: to_currency.symbol,
      amount: amount,
      amount_gained: amount_gained
    }.as_json(options)
  end

  private

  def set_currency_prices
    self.from_currency_price_in_usd = from_currency.price_in_usd
    self.to_currency_price_in_usd = to_currency.price_in_usd
  end
end
