class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.bulk_discounts.create!(percent: params[:percent], threshold: params[:threshold])
    redirect_to "/merchant/#{@merchant.id}/bulk_discounts"
  end
end