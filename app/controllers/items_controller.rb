class ItemsController < ApplicationController
  def index
    render 'items/index'
  end

  def new
    @item = Item.new
  end
end
