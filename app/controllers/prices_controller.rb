require 'csv'
require 'json'
require 'statistics'

class PricesController < ApplicationController
  before_action :set_price, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, only: %i[ create new edit update destroy ]

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(:id])
    end

    # Only allow a list of trusted parameters through.
    def token_params
      params.require(:price).permit(:asset, :token_id, :closing_price, :prev_closing_price, :volatility, :natural_log, :price_date)
    end

    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    def access_whitelist
      current_user.try(:admin?)
    end

end
