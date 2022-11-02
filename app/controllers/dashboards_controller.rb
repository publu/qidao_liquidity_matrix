require 'json'
class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.sum(:liquidity)
    @networks = Network.all
    @tokens = Token.all
    @minters = Minter.where.not(link: "")
    @mai_debt = Token.sum(:mai_debt)
    @chart_debt = Network.all.pluck(:name, :debtpercent)
    @chain_debt = Network.all
    @chart_liquidity = Token.where.not(minter_id: 4).group(:symbol).order(liquidity: :desc).limit(15).sum(:liquidity)
    @byliquidity = Token.includes(:network).where.not(minter_id: 4).order(liquidity: :desc).limit(20)
    @byvolatility = Token.includes(:network).where.not(minter_id: 4).order(risk_volatility: :asc).limit(20)
    @byscore = Token.includes(:network).where.not(minter_id: 4).order_by_grade.order(liquidity: :desc).limit(20)
  end

end
