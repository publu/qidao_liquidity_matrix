require 'json'
class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.sum(:liquidity)
    @networks = Network.all
    @tokens = Token.all
    @minters = Minter.where.not(link: "")
    @chart_debt = Network.group(:name).sum(:liquidity)
    @chart_liquidity = Token.where.not(minter_id: 4).group(:symbol).sum(:liquidity)
    @byliquidity = Token.includes(:network).where.not(minter_id: 4).order(liquidity: :desc).limit(25)
    @byvolatility = Token.includes(:network).where.not(minter_id: 4).order(risk_volatility: :asc).limit(20)
    @byscore = Token.includes(:network).where.not(minter_id: 4).order_by_grade.order(liquidity: :desc).limit(20)
  end

end
