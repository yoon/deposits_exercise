class DepositsController < ApplicationController
  before_action :set_tradeline, only: %i[ index show create ]
  before_action :set_deposit, only: %i[ show ]

  # GET /tradelines/1/deposits.json
  def index
    render json: @tradeline.deposits
  end

  # GET /tradelines/1/deposits/1.json
  def show
    render json: @deposit
  end

  # POST /tradelines/1/deposits.json
  def create
    @deposit = @tradeline.deposits.build(deposit_params)

    if @deposit.save
      render json: @deposit
    else
      render json: { error: @deposit.errors }, status: :unprocessable_entity
    end
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: e.message }, status: :bad_request
  end

  private
    def set_tradeline
      @tradeline = Tradeline.find(params[:tradeline_id])
    end

    def set_deposit
      @deposit = @tradeline.deposits.find(params[:id])
    end

    def deposit_params
      params.require(:deposit).permit(:deposit_on, :amount, :tradeline_id)
    end
end
