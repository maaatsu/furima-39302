class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.save
      # 購入成功時の処理
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_form).permit(:shipping_address, :billing_address, :credit_card_number, :expiry_date, :security_code).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end