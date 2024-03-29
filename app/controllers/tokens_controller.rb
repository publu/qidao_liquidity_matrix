require 'csv'
require 'json'
require 'statistics'

class TokensController < ApplicationController
  before_action :set_token, only: %i[ show edit update destroy ]
  before_action :set_networks, :set_minters
  before_action :authenticate_admin, only: %i[ create new edit update destroy ]
  before_action :update_scores, only: %i[ update ]

  def import
    file = params[:file]
    return redirect_to tokens_path, notice: 'Only CSV please' unless file.content_type == 'text/csv'

    CsvImportTokensService.new.call(file)

    redirect_to tokens_path, notice: 'Tokens imported!'
  end

  def sitemap
    @tokens = Token.all.order_by_grade.order(liquidity: :desc)
    @networks = Network.all.order(slug: :asc)
  end

  def index
      if params[:column] && params[:direction]
        @tokens = (Token.includes(:network).order(Arel.sql("#{params[:column]} #{params[:direction]}")))
      else
        @tokens = (Token.includes(:network).order_by_grade.order(liquidity: :desc))
      end
      @debt_sum = Token.all.sum(:mai_debt)
      @token_count = Network.all.sum(:tokens_count)
      respond_to do |format|
        format.xlsx do
          @tokens = Token.includes(:network).order_by_grade.order(liquidity: :desc)
          response.headers['Content-Disposition'] = "attachment; filename=qidao_liquidity_matrix.xlsx"
        end
        format.csv do
          @tokens = Token.includes(:network).order(network_id: :asc)
          send_data @tokens.to_csv
        end
        format.html
        format.js
      end
  end

  def show
    @debt_sum = Token.all.sum(:mai_debt)
    @ethereum = Token.where(symbol: "WETH")
    @bitcoin = Token.where(symbol: "WBTC")
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /tokens/new
  def new
    @token = Token.new
  end

  # GET /tokens/1/edit
  def edit
  end

  def create
    @token = Token.new(token_params)

    respond_to do |format|
      if @token.save
        format.html { redirect_to token_url(@token), notice: "Token was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @token.update(token_params)
        format.html { redirect_to token_url(@token), notice: "Token was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @token.destroy
    redirect_to root_path, status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def token_params
      params.require(:token).permit(:asset, :symbol, :contract_address, :vault_address, :coingecko, :coinmarketcap, :rubric, :network_id, :minter_id, :mai_debt, :liquidity, :trade_slippage, :volume, :centralized, :grade, :contract_days, :contract_transactions, :holders, :permissions, :risk_marketcap, :risk_volume, :risk_volatility, :token_type)
    end

    def set_networks
      @networks = Network.all.order(name: :asc)
    end

    def set_minters
      @minters = Minter.all.order(name: :asc)
    end

    def update_scores
      @token.grade = helpers.overall_score(@token)
    end

    # Check if user is admin before accessing CRUD actions
    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    def access_whitelist
      current_user.try(:admin?)
    end
end
