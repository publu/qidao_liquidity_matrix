require 'json'
class DashboardsController < ApplicationController

  def index
    @chart_liquidity = Token.where.not(minter_id: 4).group(:symbol).sum(:liquidity)
    @chart_volume = Token.where.not(minter_id: 4).group(:symbol).sum(:risk_volume)
    @byliquidity = Token.where.not(minter_id: 4).order(liquidity: :desc).limit(10)
    @byvolatility = Token.where.not(minter_id: 4).order(risk_volatility: :asc).limit(10)
    @byscore = Token.where.not(minter_id: 4).order_by_grade.order(liquidity: :desc).limit(10)
  end

end
