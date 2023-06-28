class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new]
  
  def index
    render 'items/index'
  end

  def new
    @item = Item.new
    @categories = [
      ["---", nil],
      ["メンズ", 1],
      ["レディース", 2],
      ["ベビー・キッズ", 3],
      ["インテリア・住まい・小物", 4],
      ["本・音楽・ゲーム", 5],
      ["おもちゃ・ホビー・グッズ", 6],
      ["家電・スマホ・カメラ", 7],
      ["スポーツ・レジャー", 8],
      ["ハンドメイド", 9],
      ["その他", 10]
    ]
  end
  
end
