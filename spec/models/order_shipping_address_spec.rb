require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '寄付情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it '正常に保存されること' do
        expect(@order_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'クレジットカード情報が必須であること' do
        @order_shipping_address.token = nil
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:token]).to include("can't be blank")
      end

      it '郵便番号が必須であること' do
        @order_shipping_address.postal_code = nil
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:postal_code]).to include("can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列でない場合、保存できないこと' do
        @order_shipping_address.postal_code = '1234567'
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:postal_code]).to include('is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県が必須であること' do
        @order_shipping_address.prefecture_id = 1
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:prefecture_id]).to include("can't be blank")
      end

      it '市区町村が必須であること' do
        @order_shipping_address.city = nil
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:city]).to include("can't be blank")
      end

      it '番地が必須であること' do
        @order_shipping_address.address = nil
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:address]).to include("can't be blank")
      end

      it '電話番号が必須であること' do
        @order_shipping_address.telephone_number = nil
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:telephone_number]).to include("can't be blank")
      end

      it '電話番号が10桁以上11桁以内の半角数値のみ保存可能であること' do
        @order_shipping_address.telephone_number = '090-1234-5678'
        expect(@order_shipping_address).not_to be_valid
        expect(@order_shipping_address.errors[:telephone_number]).to include('is invalid. Input only number')
      end
    end
  end
end
