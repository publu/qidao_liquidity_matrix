require 'json'
class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.sum(:liquidity)
    @networks = Network.all
    @tokens = Token.all
    @minters = Minter.where.not(link: "")
    @chain_debt = Network.group(:name).order_by_percent.sum(:debtamount)
    @collateral_debt = Token.where.not(minter_id: 4).order_by_debt.group(:symbol).sum(:mai_debt)
    @backing_type = Token.where.not(minter_id: 4).group(:token_type).sum(:mai_debt)
    @grade_debt = Token.where.not(minter_id: 4).order_by_grade.group(:grade).sum(:mai_debt)
    @byliquidity = Token.includes(:network).where.not(minter_id: 4).order_by_liquidity.limit(20)
    @byvolatility = Token.includes(:network).where.not(minter_id: 4).order_by_volatility.limit(20)
    @byscore = Token.includes(:network).where.not(minter_id: 4).order_by_grade.order_by_liquidity.limit(20)
  end

end
