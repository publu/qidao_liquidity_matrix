require 'json'
class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.map(&:liquidity).inject(:+)
    @networks = Network.all.map(&:name)
    @tokens = Token.all.map(&:symbol)
    @tokens_sum = Token.all.sum(:mai_debt)
    stable_prices = Stableprice.joins(:stable)
    @mai_yesterday = stable_prices.where(stables: { symbol: "MAI" }).last.closing_price
    @mai_prices = stable_prices.where(stables: { symbol: "MAI" }).map { |p| [p.price_date, p.closing_price] }
    @lusd_prices = stable_prices.where(stables: { symbol: "LUSD" }).map { |p| [p.price_date, p.closing_price] }
    @mim_prices = stable_prices.where(stables: { symbol: "MIM" }).map { |p| [p.price_date, p.closing_price] }
    @susd_prices = stable_prices.where(stables: { symbol: "sUSD" }).map { |p| [p.price_date, p.closing_price] }
    @alusd_prices = stable_prices.where(stables: { symbol: "alUSD" }).map { |p| [p.price_date, p.closing_price] }
    @chain_debt = Network.joins(:tokens).group(:name).sum(:mai_debt)
    @collateral_debt = Token.joins(:network).where.not(minter_id: 4).group(:symbol).sum(:mai_debt)
    @backing_type = Token.where.not(minter_id: 4).group(:token_type).sum(:mai_debt)
    @grade_debt = Token.where.not(minter_id: 4).group(:grade).sum(:mai_debt)
    @mai_volatility = stable_prices.where(stables: { symbol: "MAI" }).map { |p| [p.price_date, p.volatility] }
    @lusd_volatility = stable_prices.where(stables: { symbol: "LUSD" }).map { |p| [p.price_date, p.volatility] }
    @mim_volatility = stable_prices.where(stables: { symbol: "MIM" }).map { |p| [p.price_date, p.volatility] }
    @susd_volatility = stable_prices.where(stables: { symbol: "sUSD" }).map { |p| [p.price_date, p.volatility] }
    @alusd_volatility = stable_prices.where(stables: { symbol: "alUSD" }).map { |p| [p.price_date, p.volatility] }
    @byliquidity = Token.includes(:network).where.not(minter_id: 4).order(liquidity: :desc).limit(10)
    @byvolatility = Token.includes(:network).where.not(minter_id: 4).order(risk_volatility: :asc).limit(10)
    @byscore = Token.includes(:network).where.not(minter_id: 4).order_by_grade.order(liquidity: :desc).limit(10)
  end
end
