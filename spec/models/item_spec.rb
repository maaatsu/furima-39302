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

      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = 1 # カテゴリーに「---」の値
        @item.valid?
        expect(@item.errors[:category_id]).to include("can't be blank")
      end

      it '商品の状態の情報が必須であること' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.status_id = 1 # 商品の状態に「---」の値
        @item.valid?
        expect(@item.errors[:status_id]).to include("can't be blank")
      end

      it '配送料の負担の情報が必須であること' do
        @item.shipping_fee_status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end

      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.shipping_fee_status_id = 1 # 配送料の負担に「---」の値
        @item.valid?
        expect(@item.errors[:shipping_fee_status_id]).to include("can't be blank")
      end

      it '発送元の地域の情報が必須であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.prefecture_id = 1 # 発送元の地域に「---」の値
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include("can't be blank")
      end

      it '発送までの日数の情報が必須であること' do
        @item.scheduled_delivery_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end

      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.scheduled_delivery_id = 1 # 発送までの日数に「---」の値
        @item.valid?
        expect(@item.errors[:scheduled_delivery_id]).to include("can't be blank")
      end

      it '価格の情報が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300円未満では出品できない' do
        @item.price = 100 # 価格が範囲外の値（¥300未満）
        @item.valid?
        expect(@item.errors[:price]).to include('Price is out of setting range')
      end

      it '価格が9_999_999円を超えると出品できない' do
        @item.price = 10_000_000 # 価格が範囲外の値（¥9,999,999超過）
        @item.valid?
        expect(@item.errors[:price]).to include('Price is out of setting range')
      end

      it '価格に半角数字以外が含まれている場合は出品できない' do
        @item.price = '１０００' # 全角数字
        @item.valid?
        expect(@item.errors[:price]).to include('Price is invalid. Input half-width characters')
      end
      
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors[:user]).to include("must exist")
      end
    end
  end
end
