class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :check_item_status, only: :index
  
  def index
    @item = Item.find(params[:item_id])

    if current_user == @item.user || @item.sold?
      redirect_to root_path
    else
      @order_shipping_address = OrderShippingAddress.new
      @prefectures = Prefecture.all
    end

  end

  def new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    @order_shipping_address.item_id = @item.id
    @order_shipping_address.user_id = current_user.id

    @prefectures = Prefecture.all

    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :telephone_number).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_shipping_address_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def check_item_status
    if user_signed_in?
      @item = Item.find(params[:item_id])
      redirect_to root_path if current_user == @item.user || @item.sold?
    end
  end
  
end