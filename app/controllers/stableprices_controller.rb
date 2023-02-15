require 'csv'
require 'json'
require 'statistics'

class StablepricesController < ApplicationController
  before_action :set_price, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, only: %i[ create new edit update destroy ]

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @stableprice = Stableprice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def token_params
      params.require(:stableprice).permit(:asset, :stable_id, :closing_price, :volatility, :natural_log, :price_date)
    end

    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    def access_whitelist
      current_user.try(:admin?)
    end

end
