require 'json'
class DashboardsController < ApplicationController

  def index
    @liquidity = Token.all.sum(:liquidity)
    @networks = Network.all
    @tokens = Token.all
    @minters = Minter.where.not(link: "")
    @chain_debt = Network.group(:name).sum(:debtamount)
    @collateral_debt = Token.where.not(minter_id: 4).group(:symbol).order(:mai_debt).sum(:mai_debt)
    @backing_type = Token.where.not(minter_id: 4).group(:token_type).order(:mai_debt).sum(:mai_debt)
    @grade_debt = Token.where.not(minter_id: 4).group(:grade).order(:grade).sum(:mai_debt)
    @byliquidity = Token.includes(:network).where.not(minter_id: 4).order(liquidity: :desc).limit(20)
    @byvolatility = Token.includes(:network).where.not(minter_id: 4).order(risk_volatility: :asc).limit(20)
    @byscore = Token.includes(:network).where.not(minter_id: 4).order_by_grade.order(liquidity: :desc).limit(20)
  end

end
