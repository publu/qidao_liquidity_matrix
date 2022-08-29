require 'json'
class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.sum(:liquidity)
    @networks = Network.all
    @tokens = Token.all
    @minters = Minter.where.not(link: "")
    @mai_debt = Token.sum(:mai_debt)
    @chart_liquidity = Token.where.not(minter_id: 4).group(:symbol).sum(:liquidity)
    @chart_volume = Token.where.not(minter_id: 4).group(:symbol).sum(:risk_volume)
    @byliquidity = Token.includes(:network).where.not(minter_id: 4).order(liquidity: :desc).limit(10)
    @byvolatility = Token.includes(:network).where.not(minter_id: 4).order(risk_volatility: :asc).limit(10)
    @byscore = Token.includes(:network).where.not(minter_id: 4).order_by_grade.order(liquidity: :desc).limit(10)
    @bydebt = Token.includes(:network).where(minter_id: 1).order(mai_debt: :desc).limit(10)
  end

end
