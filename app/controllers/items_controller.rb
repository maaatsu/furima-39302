class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create, :edit, :update]

  def index
    @items = Item.order('created_at DESC')
    render 'items/index'
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_variables
    @categories = Category.all
    @shipping_fee_statuses = ShippingFeeStatus.all
    @prefectures = Prefecture.all
    @statuses = Status.all
    @scheduled_deliveries = ScheduledDelivery.all
  end

  def check_ownership
    return if @item.user == current_user && !@item.sold_out?
    redirect_to root_path
  end
end
