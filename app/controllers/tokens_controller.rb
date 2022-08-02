require 'csv'

class TokensController < ApplicationController
  before_action :set_token, only: %i[ show edit update destroy ]
  before_action :set_networks
  before_action :authenticate_user!, only: %i[ create new edit update destroy ]
  before_action :authenticate_admin, only: %i[ create new edit update destroy ]
  before_action :update_scores, only: %i[ update ]

  # GET /tokens or /tokens.json
  def index
      if params[:column] && params[:direction]
        @pagy, @tokens = pagy(Token.all.order(Arel.sql("#{params[:column]} #{params[:direction]}")))
      else
        @pagy, @tokens = pagy(Token.all.order_by_grade.order(liquidity: :desc))
      end
      @token_count = Token.all.size
      respond_to do |format|
        format.xlsx do
          @tokens = Token.all.order_by_grade.order(liquidity: :desc)
          response.headers['Content-Disposition'] = "attachment; filename=qidao_liquidity_matrix.xlsx"
        end
        format.html
        format.js
      end
  end

  # GET /tokens/1 or /tokens/1.json
  def show
  end

  # GET /tokens/new
  def new
    @token = Token.new
  end

  # GET /tokens/1/edit
  def edit
  end

  # POST /tokens or /tokens.json
  def create
    @token = Token.new(token_params)

    respond_to do |format|
      if @token.save
        format.html { redirect_to token_url(@token), notice: "Token was successfully created." }
        format.json { render :show, status: :created, location: @token }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tokens/1 or /tokens/1.json
  def update
    respond_to do |format|
      if @token.update(token_params)
        format.html { redirect_to token_url(@token), notice: "Token was successfully updated." }
        format.json { render :show, status: :ok, location: @token }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tokens/1 or /tokens/1.json
  def destroy
    @token.destroy

    respond_to do |format|
      format.html { redirect_to tokens_url, notice: "Token was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def token_params
      params.require(:token).permit(:asset, :symbol, :contract_address, :coingecko, :coinmarketcap, :rubric, :network_id, :liquidity, :trade_slippage, :volume, :centralized, :grade, :contract_days, :contract_transactions, :holders, :permissions, :risk_marketcap, :risk_volume, :risk_volatility)
    end

    def set_networks
      @networks = Network.all.order(name: :asc)
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
