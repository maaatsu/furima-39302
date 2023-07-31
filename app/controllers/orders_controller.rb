class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_item_status, only: :index
  before_action :check_login_status, only: :new
  
  def index
    @item = Item.find_by(id: params[:item_id])
    if current_user == @item.user
      redirect_to root_path
    else
      @order_shipping_address = OrderShippingAddress.new
      @prefectures = Prefecture.all
    end
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    @order_shipping_address.user_id = current_user.id
    @order_shipping_address.item_id = params[:item_id]
    @prefectures = Prefecture.all

    @item = Item.find(params[:item_id]) 

    if @order_shipping_address.valid?
      @order = current_user.orders.build(item: @item)
      @order.save

      @order_shipping_address.save
      pay_item
      redirect_to root_path
    else
      render 'index'
    end
  end

  def new
    @item = Item.find_by(id: params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
    @prefectures = Prefecture.all
  end

  private

  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name,
                                                   :telephone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_shipping_address_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def check_item_status
    return unless user_signed_in?

    @item = Item.find_by(id: params[:item_id]) 
    redirect_to root_path if current_user == @item.user
  end

  def check_login_status
    return if user_signed_in?
    
    redirect_to new_user_session_path
  end

end
