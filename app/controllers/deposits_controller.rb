class DepositsController < ApplicationController
  before_action :set_deposit, only: %i[ show update destroy ]

  # GET /deposits
  # GET /deposits.json
  def index
    @deposits = Deposit.all
  end

  # GET /deposits/1
  # GET /deposits/1.json
  def show
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)

    if @deposit.save
      render :show, status: :created, location: @deposit
    else
      render json: @deposit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deposits/1
  # PATCH/PUT /deposits/1.json
  def update
    if @deposit.update(deposit_params)
      render :show, status: :ok, location: @deposit
    else
      render json: @deposit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deposits/1
  # DELETE /deposits/1.json
  def destroy
    @deposit.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def deposit_params
      params.require(:deposit).permit(:deposit_on, :amount, :tradeline_id)
    end
end
