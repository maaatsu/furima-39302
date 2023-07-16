class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
    render 'items/index'
  end

  def new
    @item = Item.new
    @categories = Category.all
    @shipping_fee_statuses = ShippingFeeStatus.all
    @prefectures = Prefecture.all
    @statuses = Status.all
    @scheduled_deliveries = ScheduledDelivery.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      redirect_to root_path
    else
      @categories = Category.all
      @shipping_fee_statuses = ShippingFeeStatus.all
      @prefectures = Prefecture.all
      @statuses = Status.all
      @scheduled_deliveries = ScheduledDelivery.all

      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
    @shipping_fee_statuses = ShippingFeeStatus.all
    @prefectures = Prefecture.all
    @statuses = Status.all
    @scheduled_deliveries = ScheduledDelivery.all
end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def check_ownership
    unless @item.user == current_user
      redirect_to root_path
    end
  end
end
