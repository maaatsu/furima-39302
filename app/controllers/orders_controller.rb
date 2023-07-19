class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @purchase_form = PurchaseForm.new
  end

  def create
    @order = Order.create(order_params)
    ShippingAddress.create(shipping_address_params)
    redirect_to root_path
  end

  private

  def shipping_address_params
    params.permit(:postal_code, :prefecture_id, :city, :address, :building_name, :telephone_number, :order).merge(order_id: @order.id)
  end
end