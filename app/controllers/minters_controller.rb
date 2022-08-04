class MintersController < ApplicationController
  before_action :set_minter, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, only: %i[ import create new edit update destroy ]

  def import
    file = params[:file]
    return redirect_to minters_path, notice: 'Only CSV please' unless file.content_type == 'text/csv'

    CsvImportMintersService.new.call(file)

    redirect_to minters_path, notice: 'Chains imported!'
  end

  # GET /minters or /minters.json
  def index
    @minters = Minter.all.order(name: :asc)
    respond_to do |format|
      format.csv do
        @minters = Minter.all.order(id: :asc)
        send_data @minters.to_csv
      end
      format.html
      format.js
    end
  end

  # GET /minters/1 or /minters/1.json
  def show
    if params[:column] && params[:direction]
      @pagy, @tokens = pagy(Token.where(minter_id: @minter.id).order(Arel.sql("#{params[:column]} #{params[:direction]}")))
    else
      @pagy, @tokens = pagy(Token.where(minter_id: @minter.id).order_by_grade.order(liquidity: :desc))
      @token_count = Token.where(minter_id: @minter.id).size
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /minters/new
  def new
    @minter = Minter.new
  end

  # GET /minters/1/edit
  def edit
  end

  # POST /minters or /minters.json
  def create
    @minter = Minter.new(minter_params)

    respond_to do |format|
      if @minter.save
        format.html { redirect_to minter_url(@minter), notice: "Minter was successfully created." }
        format.json { render :show, status: :created, location: @minter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @minter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /minters/1 or /minters/1.json
  def update
    respond_to do |format|
      if @minter.update(minter_params)
        format.html { redirect_to minter_url(@minter), notice: "Minter was successfully updated." }
        format.json { render :show, status: :ok, location: @minter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @minter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /minters/1 or /minters/1.json
  def destroy
    @minter.destroy

    respond_to do |format|
      format.html { redirect_to minters_url, notice: "Minter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minter
      @minter = Minter.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def minter_params
      params.require(:minter).permit(:name, :link)
    end

    # Check if user is admin before accessing CRUD actions
    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    def access_whitelist
      current_user.try(:admin?)
    end
end
