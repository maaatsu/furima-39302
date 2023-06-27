class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new]
  
  def index
    render 'items/index'
  end

  def new
    @item = Item.new
  end
end
