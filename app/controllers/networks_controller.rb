class NetworksController < ApplicationController
  before_action :set_network, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, only: %i[ import create new edit update destroy ]


  def import
    file = params[:file]
    return redirect_to networks_path, notice: 'Only CSV please' unless file.content_type == 'text/csv'

    CsvImportNetworksService.new.call(file)

    redirect_to networks_path, notice: 'Chains imported!'
  end

  # GET /networks or /networks.json
  def index
    @networks = Network.all.order(name: :asc)
    respond_to do |format|
      format.csv do
        @networks = Network.all.order(id: :asc)
        send_data @networks.to_csv
      end
      format.html
      format.js
    end
  end

  # GET /networks/1 or /networks/1.json
  def show
    if params[:column] && params[:direction]
      @pagy, @tokens = pagy(Token.where(network_id: @network.id).order(Arel.sql("#{params[:column]} #{params[:direction]}")))
    else
      @pagy, @tokens = pagy(Token.where(network_id: @network.id).order_by_grade.order(liquidity: :desc))
      @token_count = Token.where(network_id: @network.id).size
    end
    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=qidao_liquidity_matrix.xlsx"
      end
      format.html
      format.js
    end
  end

  # GET /networks/new
  def new
    @network = Network.new
  end

  # GET /networks/1/edit
  def edit
  end

  # POST /networks or /networks.json
  def create
    @network = Network.new(network_params)

    respond_to do |format|
      if @network.save
        format.html { redirect_to network_url(@network), notice: "Network was successfully created." }
        format.json { render :show, status: :created, location: @network }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /networks/1 or /networks/1.json
  def update
    respond_to do |format|
      if @network.update(network_params)
        format.html { redirect_to network_url(@network), notice: "Network was successfully updated." }
        format.json { render :show, status: :ok, location: @network }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /networks/1 or /networks/1.json
  def destroy
    @network.destroy

    respond_to do |format|
      format.html { redirect_to networks_url, notice: "Network was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network
      @network = Network.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def network_params
      params.require(:network).permit(:name, :color, :blockchain_explorer)
    end

    # Check if user is admin before accessing CRUD actions
    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    def access_whitelist
      current_user.try(:admin?)
    end
end
