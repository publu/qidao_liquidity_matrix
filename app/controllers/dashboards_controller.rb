require 'json'
class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.sum(:liquidity)
    @networks = Network.all
    @tokens = Token.all
    @mai_yesterday = Stable.first.stableprices.last.closing_price
    @mai_prices = Stable.first.stableprices.pluck(:price_date, :closing_price)
    @lusd_prices = Stable.where(symbol: "LUSD").first.stableprices.pluck(:price_date, :closing_price)
    @mim_prices = Stable.where(symbol: "MIM").first.stableprices.pluck(:price_date, :closing_price)
    @susd_prices = Stable.where(symbol: "sUSD").first.stableprices.pluck(:price_date, :closing_price)
    @alusd_prices = Stable.where(symbol: "alUSD").first.stableprices.pluck(:price_date, :closing_price)
    @minters = Minter.where.not(link: "")
    @chain_debt = Network.group(:name).sum(:debtamount)
    @collateral_debt = Token.where.not(minter_id: 4).group(:symbol).sum(:mai_debt)
    @backing_type = Token.where.not(minter_id: 4).group(:token_type).sum(:mai_debt)
    @grade_debt = Token.where.not(minter_id: 4).group(:grade).sum(:mai_debt)
    @mai_volatility = Stable.first.stableprices.pluck(:price_date, :volatility)
    @lusd_volatility = Stable.where(symbol: "LUSD").first.stableprices.pluck(:price_date, :volatility)
    @mim_volatility = Stable.where(symbol: "MIM").first.stableprices.pluck(:price_date, :volatility)
    @susd_volatility = Stable.where(symbol: "sUSD").first.stableprices.pluck(:price_date, :volatility)
    @alusd_volatility = Stable.where(symbol: "alUSD").first.stableprices.pluck(:price_date, :volatility)
    @byliquidity = Token.includes(:network).where.not(minter_id: 4).order(liquidity: :desc).limit(10)
    @byvolatility = Token.includes(:network).where.not(minter_id: 4).order(risk_volatility: :asc).limit(10)
    @byscore = Token.includes(:network).where.not(minter_id: 4).order_by_grade.order(liquidity: :desc).limit(10)
  end

end
