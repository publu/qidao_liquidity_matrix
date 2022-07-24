class TokensController < ApplicationController
  before_action :set_token, only: %i[ show edit update destroy ]
  before_action :set_networks

  # GET /tokens or /tokens.json
  def index
      # @tokens = Token.search(params).order(liquidity: :desc, symbol: :asc)
      @tokens = Token.all.order(liquidity: :desc, symbol: :asc)
      respond_to do |format|
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
      @token = Token.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def token_params
      params.require(:token).permit(:asset, :symbol, :contract_address, :coingecko, :coinmarketcap, :rubric, :network_id, :liquidity, :trade_slippage, :volume, :centralized, :grade, :contract_days, :contract_transactions, :holders, :permissions, :risk_marketcap, :risk_volume, :risk_volatility)
    end

    def set_networks
      @networks = Network.all.order(name: :asc)
    end
end
