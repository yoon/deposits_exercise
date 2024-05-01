class TradelinesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: Tradeline.all, methods: :balance
  end

  def show
    render json: Tradeline.find(params[:id]), methods: :balance
  end

  private

  def not_found
    render json: 'not_found', status: :not_found
  end
end
