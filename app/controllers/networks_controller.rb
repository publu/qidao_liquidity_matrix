class NetworksController < ApplicationController
  before_action :set_network, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, only: %i[ create new edit update destroy ]


  def import
    file = params[:file]
    return redirect_to networks_path, notice: 'Only CSV please' unless file.content_type == 'text/csv'

    CsvImportNetworksService.new.call(file)

    redirect_to networks_path, notice: 'Chains imported!'
  end

  def index
    @networks = Network.all.order(name: :asc)
    @debt_sum = Network.all.sum(:debtamount)
    respond_to do |format|
      format.csv do
        @networks = Network.all.order(id: :asc)
        send_data @networks.to_csv
      end
      format.html
      format.js
    end
  end

  def show
    if params[:column] && params[:direction]
      @tokens = (Token.includes(:network).where(network_id: @network.id).order(Arel.sql("#{params[:column]} #{params[:direction]}")))
    else
      @tokens = (Token.includes(:network).where(network_id: @network.id).order_by_grade.order(liquidity: :desc))
      @token_count = Token.where(network_id: @network.id).size
    end
    @debt_sum = Token.all.sum(:mai_debt)
    respond_to do |format|
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

  def create
    @network = Network.new(network_params)

    respond_to do |format|
      if @network.save
        format.html { redirect_to network_url(@network), notice: "Network was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @network.update(network_params)
        format.html { redirect_to network_url(@network), notice: "Network was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @network.destroy
    redirect_to root_path, status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network
      @network = Network.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def network_params
      params.require(:network).permit(:name, :gecko_id, :chain_id, :color, :blockchain_explorer, :liquidity, :volume, :debtamount, :debtpercent, :image)
    end

    # Check if user is admin before accessing CRUD actions
    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    def access_whitelist
      current_user.try(:admin?)
    end
end
