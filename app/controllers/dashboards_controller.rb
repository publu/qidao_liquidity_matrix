class DashboardsController < ApplicationController

  def index
    @chart_liquidity = Token.group(:symbol).sum(:liquidity)
    @chart_volume = Token.group(:symbol).sum(:risk_volume)
    @byliquidity = Token.order(liquidity: :desc).limit(10)
    @byvolatility = Token.order(risk_volatility: :asc).limit(10)
    @byscore = Token.order_by_grade.order(liquidity: :desc).limit(10)
  end

end
