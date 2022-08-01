class ChartsController < ApplicationController
  def tokens_by_liquidity
    render json: Token.group(:symbol).sum(:liquidity)
  end
end
