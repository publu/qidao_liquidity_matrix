require 'json'

class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.map(&:liquidity).inject(:+)
    @networks = Network.all.map(&:name)
    @tokens = Token.all.map(&:symbol)
    @tokens_sum = Token.all.sum(:mai_debt)
    stable_prices = Stableprice.joins(:stable)
    @mai_yesterday = stable_prices.where(stables: { symbol: "MAI" }).last.closing_price
    @mai_prices = stable_prices.where(stables: { symbol: "MAI" }).last(30).map { |p| [p.price_date.strftime("%b %d, %Y"), p.closing_price] }
    @chain_debt = Network.joins(:tokens).group(:name).sum(:mai_debt)
    @collateral_debt = Token.joins(:network).where.not(minter_id: 4).group(:symbol).sum(:mai_debt)
    @backing_type = Token.where.not(minter_id: 4).group(:token_type).sum(:mai_debt)
    @grade_debt = Token.where.not(minter_id: 4).group(:grade).sum(:mai_debt)
    @mai_volatility = stable_prices.where(stables: { symbol: "MAI" }).last(90).map { |p| [p.price_date.strftime("%b %d, %Y"), p.volatility] }
    @lusd_volatility = stable_prices.where(stables: { symbol: "LUSD" }).last(90).map { |p| [p.price_date.strftime("%b %d, %Y"), p.volatility] }
    @mim_volatility = stable_prices.where(stables: { symbol: "MIM" }).last(90).map { |p| [p.price_date.strftime("%b %d, %Y"), p.volatility] }
    @susd_volatility = stable_prices.where(stables: { symbol: "sUSD" }).last(90).map { |p| [p.price_date.strftime("%b %d, %Y"), p.volatility] }
    @alusd_volatility = stable_prices.where(stables: { symbol: "alUSD" }).last(90).map { |p| [p.price_date.strftime("%b %d, %Y"), p.volatility] }
  end

  def stables
    @stables = Stableprice.joins(:stable)
    respond_to do |format|
      format.json
    end
  end

end
