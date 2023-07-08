class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new]
  
  def index
    render 'items/index'
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
    @categories = Category.all
    @shipping_fee_statuses = Shipping_fee_status.all
    @prefecture = Prefecture.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @shipping_fee_statuses = Shipping_fee_status.all
    
    
    if @item.save
      redirect_to root_path
    else
      @categories = Category.all
      @shipping_fee_statuses = Shipping_fee_status.all
      @prefecture = Prefecture.all

      render :new
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery, :price)
  end  
  
end
