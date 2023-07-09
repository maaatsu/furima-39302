require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品機能' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '正常な場合' do
      it '正常に出品できること' do
        expect(@item).to be_valid
      end
    end

    context '異常な場合' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態の情報が必須であること' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担の情報が必須であること' do
        @item.shipping_fee_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end

      it '発送元の地域の情報が必須であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数の情報が必須であること' do
        @item.scheduled_delivery_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end

      it '価格の情報が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格は、¥300~¥9,999,999の間のみ保存可能であること' do
        @item.price = 100 # 価格が範囲外の値（¥300未満）
        @item.valid?
        expect(@item.errors[:price]).to include('Price is out of setting range')

        @item.price = 10_000_000 # 価格が範囲外の値（¥9,999,999超過）
        @item.valid?
        expect(@item.errors[:price]).to include('Price is out of setting range')
      end

      it '価格は半角数値のみ保存可能であること' do
        @item.price = '１０００' # 全角数字
        @item.valid?
        expect(@item.errors[:price]).to include('Price is invalid. Input half-width characters')

        @item.price = 'abc' # 文字列
        @item.valid?
        expect(@item.errors[:price]).to include('Price is invalid. Input half-width characters')

        @item.price = '1000' # 半角数字
        @item.valid?
        expect(@item.errors[:price]).to be_empty
      end
    end
  end
end
