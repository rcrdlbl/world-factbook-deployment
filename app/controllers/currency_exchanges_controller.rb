class CurrencyExchangesController < ApplicationController
  def show
    @currency_exchanges = CurrencyExchange.where({selected_currency: params[:id]})
    render json: @currency_exchanges
  end

  def create
    # url = "https://free.currencyconverterapi.com/api/v6/convert?q=#{params[:target_currency]},#{params[:user_currency]}&compact=ultra&apiKey=f6bab8fe616b507f44af"
    # response = HTTParty.get(url)
    # binding.pry
    @currency_exchange = CurrencyExchange.create(currency_exchange_params) do |c|
      url = "https://free.currencyconverterapi.com/api/v6/convert?q=#{c.selected_currency}_#{c.user_currency}&compact=ultra&apiKey=f6bab8fe616b507f44af"
      response = HTTParty.get(url)
      c.result = response.values[0]
    end
    if @currency_exchange.save
      render json: @currency_exchange, status: :created
    end
  end

  private
  def currency_exchange_params
    params.require(:currency_exchange).permit(:selected_currency, :user_currency)
  end

end
